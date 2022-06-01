//
//  ContentView.swift
//  Shared
//
//  Created by Wei Lun Hsu on 2022/5/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Watch()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Watch: View {
    @State var date: Date = Date()
    private var timer: Timer?
    
    var body: some View {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        var minAngle: Double = 0
        var hourAngle: Double = 0
        var secondAngle: Double = 0
        
        if let hour = dateComponents.hour,
           let minute = dateComponents.minute,
           let second = dateComponents.second
        {
            let radianInHour = 2 * Double.pi / 12
            let radianInOneMinute = 2 * Double.pi / 60
            let actualHour = Double(hour) + (Double(minute) / 60)
            hourAngle = actualHour + radianInHour
            minAngle = Double(minute) * radianInOneMinute
            secondAngle = Double(second) * radianInOneMinute
        }
        
        return ZStack {
            Arc(start: .radians(0), end: .radians(Double.pi * 2))
                .stroke(lineWidth: 3)
            Ticks()
            Numbers()
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
            Hand(offset: 30)
                .frame(width: 4, alignment: .center)
                .rotationEffect(.radians(hourAngle))
            Hand(offset: 10)
                .frame(width: 3, alignment: .center)
                .rotationEffect(.radians(minAngle))
            Hand(offset: 5)
                .foregroundColor(.red)
                .frame(width: 2, alignment: .center)
                .rotationEffect(.radians(secondAngle))
            Circle()
                .foregroundColor(.red)
                .frame(width: 7, height: 7, alignment: .center)
        }
        .frame(width: 200, height: 200, alignment: .leading)
        .onAppear(perform: start)
    }
    
    private func start() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.date = Date()
        }
    }

}

struct Ticks: View {
    var body: some View {
        ForEach(0 ..< 60) {
            Tick(length: $0 % 5 == 0 ? 10 : 5)
                .stroke(lineWidth: 2)
                .rotationEffect(.radians(.pi * 2 / 60 * Double($0)))
        }
    }
}

struct Numbers: View {
    var body: some View {
        ForEach(1 ..< 13) {
            Number(hour: $0)
        }
    }
}

struct Number: View {
    var hour: Int
    var body: some View {
        VStack {
            Text("\(hour)")
                .fontWeight(.bold)
                .rotationEffect(.radians(-.pi * 2 / 12 * Double(hour)))
            Spacer()
        }
        .padding()
        .rotationEffect(.radians(.pi * 2 / 12 * Double(hour)))
    }
}

// MARK: - Shape

struct Arc: Shape {
    var start: Angle = .radians(0)
    var end: Angle = .radians(Double.pi * 2)
    /// 順時針
    var clockWise: Bool = true
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width / 2, rect.height / 2)
        path.addArc(center: center, radius: radius, startAngle: start, endAngle: end, clockwise: clockWise)
        return path
    }
}

struct Tick: Shape {
    var length: CGFloat = 5
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + length))
        return path
    }
}

struct Hand: Shape {
    var offset: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: .init(
                origin: .init(x: rect.origin.x, y: rect.origin.y + offset),
                size: .init(width: rect.width, height: rect.height / 2 - offset)),
            cornerSize: .init(width: rect.width / 2, height: rect.width / 2)
        )
        return path
    }
}
