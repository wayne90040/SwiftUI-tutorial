//
//  ContentView.swift
//  Shared
//
//  Created by Wei Lun Hsu on 2022/5/30.
//

import SwiftUI

struct ContentView: View {
    
    @State var hour: Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    
    private var timer: Timer?
    
    var body: some View {
        VStack {
            CircleClock(hour: $hour, minute: $minute, second: $second)
            DigitalClock(hour: $hour, minute: $minute, second: $second)
        }
        .onAppear(perform: startTimer)
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
            hour = components.hour ?? 0
            minute = components.minute ?? 0
            second = components.second ?? 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
