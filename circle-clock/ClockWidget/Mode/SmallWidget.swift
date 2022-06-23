//
//  SmallWidget.swift
//  circle-clock (iOS)
//
//  Created by Wei Lun Hsu on 2022/6/20.
//

import SwiftUI

struct SmallWidget: View {
    
    var body: some View {
        SmallClock(
            hour: 9,
            minute: 39,
            second: 2
        )
        .frame(width: 50, height: 50)
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidget()
    }
}
