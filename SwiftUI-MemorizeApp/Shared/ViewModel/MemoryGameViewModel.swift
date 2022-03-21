//
//  MemoryGameViewModel.swift
//  SwiftUI-MemorizeApp (iOS)
//
//  Created by Wei Lun Hsu on 2022/3/21.
//

import Foundation


class MemoryGameViewModel {
    
    static let emojis = [
        "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻",
        "🚚", "🚛", "🚜", "🛺", "🚄", "🚅", "🚈", "🚂", "🚀"
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        .init(numberOfPairsOfCard: 4) { index in
            emojis[index]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
     
}
