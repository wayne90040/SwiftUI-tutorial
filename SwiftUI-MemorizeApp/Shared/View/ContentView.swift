//
//  ContentView.swift
//  Shared
//
//  Created by Wei Lun Hsu on 2022/2/17.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = [
        "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻",
        "🚚", "🚛", "🚜", "🛺", "🚄", "🚅", "🚈", "🚂", "🚀"
    ]
    
    @State var maxCount: Int = 10
    
    var body: some View {
        VStack {
            
            ScrollView {
                /// `LazyVGrid` 會使用最小空間
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    /// `\.self` -> 代表自己，所以依照這個 case 來看不能有兩個相同的 `emoji`
                    /// 否則會造成一樣的行為。
                    ForEach(emojis[0..<maxCount], id: \.self) { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            Spacer()
            
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button {
            if maxCount > 1 {
                maxCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if emojis.count > maxCount {
                maxCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/// CardView
struct CardView: View {
    
    @State var isFaceUp: Bool = true
    
    let content: String
    
    var body: some View {
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                /// `.stroke` -> 會在邊線外面畫線( 所以有被切掉的風險 )
                /// `strokeBorder` -> 內側畫線
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
