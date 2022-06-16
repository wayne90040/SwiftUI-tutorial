//
//  circle_clockApp.swift
//  Shared
//
//  Created by Wei Lun Hsu on 2022/5/30.
//

import SwiftUI
import ComposableArchitecture

@main
struct CircleClockApp: App {
    
    @State var isShowSheet: Bool = false
    
    let store = Store(
        initialState: TimeZoneState(),
        reducer: timeZonerReducer,
        environment: .live
    )
    
    var body: some Scene {
        
        var rightItem: some View {
            Button {
                isShowSheet.toggle()
            } label: {
                Image(systemName: "square.grid.2x2.fill")
                    .foregroundColor(.black)
            }
        }
        
        return WindowGroup {
            NavigationView {
                ContentView(store: store.scope(state: \.clockState))
                    .navigationBarItems(trailing: rightItem)
            }
            .sheet(isPresented: $isShowSheet) {
                ChooseTimeZoneView(store: store.scope(state: \.searchState))
            }
            
        }
    }
}
