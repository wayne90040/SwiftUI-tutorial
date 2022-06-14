//
//  ChooseLocaleView.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/9.
//

import SwiftUI
import ComposableArchitecture

struct ChooseTimeZoneView: View {
    
    @Environment(\.dismiss) private var dismiss
    let store: Store<SearchState, TimeZoneAction>
    @State var query: String = ""

    var body: some View {
        WithViewStore(store) { store in
            NavigationView {
                List(store.timeZones, id: \.self) { item in
                    Button {
                        store.send(.choose(timeZone: item))
                        dismiss()
                    } label: {
                        Text(item)
                    }
                }
                .navigationTitle("Choose Locale")
            }
            .searchable(text: $query)
            .onChange(of: query) { _ in
                store.send(.query(text: query))
            }
            .onDisappear {
                store.send(.query(text: ""))
            }
        }
    }
}
