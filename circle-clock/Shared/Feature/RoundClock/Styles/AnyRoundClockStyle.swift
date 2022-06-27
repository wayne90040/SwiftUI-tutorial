//
//  AnyRoundClockStyle.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/27.
//

import SwiftUI


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
