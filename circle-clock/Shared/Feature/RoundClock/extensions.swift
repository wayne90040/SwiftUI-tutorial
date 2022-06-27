//
//  extensions.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/27.
//

import Foundation
import SwiftUI

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
