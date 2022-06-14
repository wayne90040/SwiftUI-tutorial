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
                startTimer(store)
            })
        }
    }
    
    private func startTimer(_ store: ViewStore<ClockState, TimeZoneAction>) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(identifier: store.timeZone) ?? TimeZone.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
            store.send(.currentTime(
                hour: components.hour ?? 0,
                minute: components.minute ?? 0,
                second: components.second ?? 0
            ))
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
