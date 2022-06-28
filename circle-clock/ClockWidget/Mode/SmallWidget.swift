//
//  SmallWidget.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/20.
//

import SwiftUI

struct SmallWidget: View {
    
    var body: some View {
        RoundClock(hour: 0, minute: 0, second: 0)
            .roundClockStyle(SmallRoundClockStyle())
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidget()
    }
}
