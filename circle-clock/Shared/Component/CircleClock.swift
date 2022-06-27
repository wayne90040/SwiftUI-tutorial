//
//  WatchView.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/7.
//

import Foundation
import SwiftUI
import WidgetKit


// TODO:

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
