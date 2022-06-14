//
//  DigitalClock.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/8.
//

import SwiftUI

struct DigitalClock: Clock {
    
    var hour: Int

    var minute: Int
    
    var second: Int
    
    var body: some View {
        Text("\n\(hour):\(minute):\(second)")
            .font(Font.FontStyle.mainFont)
    }
}

//struct DigitalClock_Previews: PreviewProvider {
//    static var previews: some View {
//        DigitalClock()
//    }
//}
