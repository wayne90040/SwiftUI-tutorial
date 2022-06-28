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
    
    var size: Double { get }
    
    var hourHandWidth: Double { get }
    
    var minHandWidth: Double { get }
    
    var secondHandWidth: Double { get }
    
    func makeBody(configuration: Self.Configuration) -> Self.Body
}


extension RoundClockStyle {
    
    var size: Double { 200 }
    
    var hourHandWidth: Double { 4 }

    var minHandWidth: Double { 3 }
    
    var secondHandWidth: Double { 2 }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        ZStack {
            configuration.arc
                .stroke(lineWidth: 3)
            
            configuration.ticks
            
            configuration.numbers
            
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
            
            configuration.hourHand
                .frame(width: secondHandWidth, alignment: .center)
                .rotationEffect(.radians(configuration.hourAngle))
            
            configuration.minHand
                .frame(width: minHandWidth, alignment: .center)
                .rotationEffect(.radians(configuration.minAngle))
            
            configuration.secondHand
                .foregroundColor(.red)
                .frame(width: secondHandWidth, alignment: .center)
                .rotationEffect(.radians(configuration.secondAngle))
            
            Circle()
                .foregroundColor(.red)
                .frame(width: 7, height: 7, alignment: .center)
        }
        .frame(width: size, height: size, alignment: .leading)
        .padding(5)
    }
}
