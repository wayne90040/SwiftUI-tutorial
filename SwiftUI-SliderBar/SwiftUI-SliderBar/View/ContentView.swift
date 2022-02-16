//
//  ContentView.swift
//  SwiftUI-SliderBar
//
//  Created by Wei Lun Hsu on 2022/2/16.
//

import SwiftUI

struct ContentView: View {
    
    /// Show Slider View
    @State private var isShowSlider = false
    
    var body: some View {
        NavigationView {
            
            ZStack {
                if isShowSlider {
                    SliderMenuView(isShowSlider: $isShowSlider)
                }
                HomeView()
                    .cornerRadius(isShowSlider ? 20 : 10)
                    .offset(x: isShowSlider ? 300 : 0, y: 0)
                    .scaleEffect(isShowSlider ? 0.8 : 1)
                    .navigationBarItems(
                        leading: Button(action: {
                            withAnimation(.spring()) {
                                isShowSlider.toggle()
                            }
                        }, label: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.black)
                        })
                    )
                    .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.automatic)
            }
            .onAppear {
                /// 解決點擊 Item 之後 SliderMenu 不會收起
                isShowSlider = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white
            
            Text("Hello, world!")
                .padding()
            
        }
        
    }
}
