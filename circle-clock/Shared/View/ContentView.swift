//
//  ContentView.swift
//  Shared
//
//  Created by Wei Lun Hsu on 2022/5/30.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: Store<ClockState, TimeZoneAction>
    
    var body: some View {
        
        WithViewStore(store) { store in
            VStack {
                CircleClock(
                    hour: store.hour,
                    minute: store.minute,
                    second: store.second
                )
                DigitalClock(
                    hour: store.hour,
                    minute: store.minute,
                    second: store.second
                )
            }
            .navigationTitle(store.timeZone)
            .onAppear(perform: {
                store.send(.start)
            })
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
