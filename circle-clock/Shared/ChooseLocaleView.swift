//
//  ChooseLocaleView.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/9.
//

import SwiftUI

struct ChooseLocaleView: View {
    var body: some View {
        VStack {
            ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) {
                Text($0)
            }
        }
    }
}
