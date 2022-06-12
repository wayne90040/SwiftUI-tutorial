//
//  ChooseLocaleView.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/9.
//

import SwiftUI

struct ChooseLocaleView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var timeZone: String
    
    var body: some View {
        
        NavigationView {
            List(TimeZone.knownTimeZoneIdentifiers, id: \.self) { item in
                Button {
                    timeZone = item
                    dismiss()
                } label: {
                    Text(item)
                }
            }
            .navigationTitle("Choose Locale")
        }
        
    }
}
