//
//  ChooseLocaleView.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/9.
//

import SwiftUI

struct ChooseTimeZoneView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var query: String = ""
    @State private var timeZones: [String] = TimeZone.knownTimeZoneIdentifiers
    @Binding var timeZone: String
    
    
    var body: some View {
        
        NavigationView {
            List(timeZones, id: \.self) { item in
                Button {
                    timeZone = item
                    dismiss()
                } label: {
                    Text(item)
                }
            }
            .navigationTitle("Choose Locale")
        }
        .searchable(text: $query)
        .onChange(of: query) { _ in
            timeZones = query.isEmpty ? TimeZone.knownTimeZoneIdentifiers : TimeZone.knownTimeZoneIdentifiers.filter { $0.contains(query) }
        }
    }
}
