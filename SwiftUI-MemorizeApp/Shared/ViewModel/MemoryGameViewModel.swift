//
//  MemoryGameViewModel.swift
//  SwiftUI-MemorizeApp (iOS)
//
//  Created by Wei Lun Hsu on 2022/3/21.
//

import Foundation


class MemoryGameViewModel: ObservableObject {
    
    static let emojis = [
        "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻",
        "🚚", "🚛", "🚜", "🛺", "🚄", "🚅", "🚈", "🚂", "🚀"
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        .init(numberOfPairsOfCard: 4) { index in
            emojis[index]
        }
    }
    
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()
    
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send() /// 和 `@Published` 前綴相同
        model.choose(card)
    }
}
