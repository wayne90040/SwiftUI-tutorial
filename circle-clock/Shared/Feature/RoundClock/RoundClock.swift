//
//  RoundClock.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/27.
//

import SwiftUI


struct RoundClock: View {
    
    @Environment(\.roundClockStyle) var style
    
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
        
        return style.makeBody(configuration: RoundClockStyleConfiguration(
            hourAngle: hourAngle, minAngle: minAngle, secondAngle: secondAngle
        ))
    }
}


extension RoundClock {
    func roundClockStyle<T: RoundClockStyle>(_ style: T) -> some View {
        environment(\.roundClockStyle, AnyRoundClockStyle(style: style))
    }
}




