//
//  WatchView.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/7.
//

import Foundation
import SwiftUI
import WidgetKit

// https://www.fivestars.blog/articles/custom-view-styles/


struct RoundClockStyleKey: EnvironmentKey {
    static var defaultValue = AnyRoundClockStyle(style: NormalRoundClockStyle())
}

extension EnvironmentValues {
    var roundClockStyle: AnyRoundClockStyle {
        get {
            self[RoundClockStyleKey.self]
        }
        set {
            self[RoundClockStyleKey.self] = newValue
        }
    }
}

struct AnyRoundClockStyle: RoundClockStyle {
    
    private var makeBody: (Configuration) -> AnyView
    
    init<T: RoundClockStyle>(style: T) {
        makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        makeBody(configuration)
    }
}


struct RoundClock: View {
    
    @Environment(\.roundClockStyle) var style
    
    var hour: Int
    var minute: Int
    var second: Int
    
    
//    var body: some View {
//
//        return style.makeBody(
//            configuration: RoundClockStyleConfiguration(
//                label: RoundClockStyleConfiguration.Label(content: content())
//            )
//        )
//    }
    
    var body: some View {

        var minAngle: Double = 0
        var hourAngle: Double = 0
        var secondAngle: Double = 0

        let radianInHour = 2 * Double.pi / 12
        let radianInOneMinute = 2 * Double.pi / 60
        let actualHour = Double(hour) + (Double(minute) / 60)

        hourAngle = actualHour * radianInHour
        minAngle = Double(minute) * radianInOneMinute
        secondAngle = Double(second) * radianInOneMinute
        
        return style.makeBody(configuration: RoundClockStyleConfiguration())

//        return ZStack {
//
//            style.makeBody(
//                configuration: RoundClockStyleConfiguration()
//            )
//
//            Arc(start: .radians(0), end: .radians(Double.pi * 2))
//                .stroke(lineWidth: 3)
//            Ticks()
//            Numbers()
//            Circle()
//                .frame(width: 15, height: 15, alignment: .center)
//            Hand(offset: 30)
//                .frame(width: 4, alignment: .center)
//                .rotationEffect(.radians(hourAngle))
//            Hand(offset: 10)
//                .frame(width: 3, alignment: .center)
//                .rotationEffect(.radians(minAngle))
//            Hand(offset: 5)
//                .foregroundColor(.red)
//                .frame(width: 2, alignment: .center)
//                .rotationEffect(.radians(secondAngle))
//            Circle()
//                .foregroundColor(.red)
//                .frame(width: 7, height: 7, alignment: .center)
//        }
//        .frame(width: 200, height: 200, alignment: .leading)
    }
}

struct RoundClockStyleConfiguration {
    
//    struct Label: View {
//
//        var body: AnyView
//
//        init<Content: View>(content: Content) {
//            body = AnyView(content)
//        }
//    }
    
//    struct Arc: View {
//        var body: some View {
//            Arc(start: .radians(0), end: .radians(Double.pi * 2))
//                .stroke(lineWidth: 3)
//        }
//    }
    
    
//    let label: RoundClockStyleConfiguration.Label
    
    let arc: Arc = Arc(start: .radians(0), end: .radians(Double.pi * 2))
    
    let ticks: Ticks = Ticks()
    
    let numbers: Numbers = Numbers()
    
    let hourHand: Hand = Hand(offset: 30)
    
    let minHand: Hand = Hand(offset: 10)
    
    let secondHand: Hand = Hand(offset: 5)
    
//    let testHand: Hand
    
//
//    let numbers = Numbers()
//
//    let circle: some View = Circle()
//
//    let hand: some View = Hand()
    
    
//    var content:  some View {
//
//        Arc(start: .radians(0), end: .radians(Double.pi * 2))
//
//    }
    
    
}


protocol RoundClockStyle {
    associatedtype Body: View
    typealias Configuration = RoundClockStyleConfiguration
    
    
    func makeBody(configuration: Self.Configuration) -> Self.Body
    
}

extension RoundClockStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        ZStack {
            configuration.arc
                .stroke(lineWidth: 3)
            
            configuration.ticks
            
            configuration.numbers
            
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
            
            configuration.hourHand
                .frame(width: 4, alignment: .center)
            
            configuration.minHand
                .frame(width: 3, alignment: .center)
            
            configuration.secondHand
                .foregroundColor(.red)
                .frame(width: 2, alignment: .center)
            Circle()
                .foregroundColor(.red)
                .frame(width: 7, height: 7, alignment: .center)
        }
        .frame(width: 200, height: 200, alignment: .leading)
    }
}



struct NormalRoundClockStyle: RoundClockStyle {
    
    
//    func makeBody(configuration: Configuration) -> some View {
//
//        ZStack {
//            configuration.content
//
//        }
//
//
////        configuration.label
////            .foregroundColor(.red)
////            .padding()
////            .background(RoundedRectangle(cornerRadius: 16).strokeBorder())
//    }
}

extension RoundClock {
    func roundClockStyle<T: RoundClockStyle>(_ style: T) -> some View {
        environment(\.roundClockStyle, AnyRoundClockStyle(style: style))
    }
}


struct SmallClock: Clock {
    
    var hour: Int
    var minute: Int
    var second: Int
    
    var body: some View {
        var minAngle: Double = 0
        var hourAngle: Double = 0
        var secondAngle: Double = 0
        
        let radianInHour = 2 * Double.pi / 12
        let radianInOneMinute = 2 * Double.pi / 60
        let actualHour = Double(hour) + (Double(minute) / 60)
        
        hourAngle = actualHour * radianInHour
        minAngle = Double(minute) * radianInOneMinute
        secondAngle = Double(second) * radianInOneMinute
        
        return ZStack {
            Arc(start: .radians(0), end: .radians(Double.pi * 2))
                .stroke(lineWidth: 3)
            Numbers()
            Circle()
                .frame(width: 5, height: 5, alignment: .center)
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
                .frame(width: 3, height: 3, alignment: .center)
        }
        .frame(
            minWidth: 120,
            maxWidth: .infinity,
            minHeight: 120,
            maxHeight: .infinity,
            alignment: .leading)
    }
}


struct CircleClock: Clock {
    
    var hour: Int
    var minute: Int
    var second: Int
//
    var body: some View {

        RoundClock(hour: 8, minute: 8, second: 8)
            .roundClockStyle(NormalRoundClockStyle())
    }
    
//    var body: some View {
//
//        var minAngle: Double = 0
//        var hourAngle: Double = 0
//        var secondAngle: Double = 0
//
//        let radianInHour = 2 * Double.pi / 12
//        let radianInOneMinute = 2 * Double.pi / 60
//        let actualHour = Double(hour) + (Double(minute) / 60)
//
//        hourAngle = actualHour * radianInHour
//        minAngle = Double(minute) * radianInOneMinute
//        secondAngle = Double(second) * radianInOneMinute
//
//        return ZStack {
//            Arc(start: .radians(0), end: .radians(Double.pi * 2))
//                .stroke(lineWidth: 3)
//            Ticks()
//            Numbers()
//            Circle()
//                .frame(width: 15, height: 15, alignment: .center)
//            Hand(offset: 30)
//                .frame(width: 4, alignment: .center)
//                .rotationEffect(.radians(hourAngle))
//            Hand(offset: 10)
//                .frame(width: 3, alignment: .center)
//                .rotationEffect(.radians(minAngle))
//            Hand(offset: 5)
//                .foregroundColor(.red)
//                .frame(width: 2, alignment: .center)
//                .rotationEffect(.radians(secondAngle))
//            Circle()
//                .foregroundColor(.red)
//                .frame(width: 7, height: 7, alignment: .center)
//        }
//        .frame(width: 200, height: 200, alignment: .leading)
//    }
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
