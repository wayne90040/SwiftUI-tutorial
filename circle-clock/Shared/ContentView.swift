//
//  ContentView.swift
//  Shared
//
//  Created by Wei Lun Hsu on 2022/5/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowSheet: Bool = false
    @State var hour: Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    private var timer: Timer?
    
    var body: some View {
        
        let rightBarItem = Button {
            isShowSheet.toggle()
        } label: {
            Image(systemName: "square.grid.2x2.fill")
                .foregroundColor(.black)
        }

        return NavigationView {
            VStack {
                CircleClock(hour: $hour, minute: $minute, second: $second)
                DigitalClock(hour: $hour, minute: $minute, second: $second)
            }
            .navigationTitle("台灣")
            .navigationBarItems(trailing: rightBarItem)
            
        }
        .onAppear(perform: startTimer)
        .sheet(isPresented: $isShowSheet) {
            ChooseLocaleView()
        }
        
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
