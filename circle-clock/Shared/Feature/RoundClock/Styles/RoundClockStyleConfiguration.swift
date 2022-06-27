//
//  RoundClockStyleConfiguration.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/27.
//

import Foundation
import SwiftUI


struct RoundClockStyleConfiguration {
    
    let arc: Arc = Arc(start: .radians(0), end: .radians(Double.pi * 2))
    
    let ticks: Ticks = Ticks()
    
    let numbers: Numbers = Numbers()
    
    let hourHand: Hand = Hand(offset: 30)
    
    let minHand: Hand = Hand(offset: 10)
    
    let secondHand: Hand = Hand(offset: 5)
    
    var hourAngle: Double
    
    var minAngle: Double
    
    var secondAngle: Double
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
