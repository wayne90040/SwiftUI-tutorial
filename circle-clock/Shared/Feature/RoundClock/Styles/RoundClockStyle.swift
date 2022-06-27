//
//  RoundClockStyle.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/27.
//

import SwiftUI


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
                .rotationEffect(.radians(configuration.hourAngle))
            
            configuration.minHand
                .frame(width: 3, alignment: .center)
                .rotationEffect(.radians(configuration.minAngle))
            
            configuration.secondHand
                .foregroundColor(.red)
                .frame(width: 2, alignment: .center)
                .rotationEffect(.radians(configuration.secondAngle))
            
            Circle()
                .foregroundColor(.red)
                .frame(width: 7, height: 7, alignment: .center)
        }
        .frame(width: 200, height: 200, alignment: .leading)
    }
}
