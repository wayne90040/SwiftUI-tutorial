//
//  MemoryGame.swift
//  SwiftUI-MemorizeApp (iOS)
//
//  Created by Wei Lun Hsu on 2022/3/21.
//

import Foundation

struct MemoryGame<T> {
    
    /// 外部只能 `Get`
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCard: Int, createCardContent: (Int) -> T) {
        cards = []
        
        for pairIndex in 0 ..< numberOfPairsOfCard {
            cards.append(.init(content: createCardContent(pairIndex)))
            cards.append(.init(content: createCardContent(pairIndex)))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        
        var isFaceUp: Bool = false
         
        var isMatched: Bool = false
        
        var content: T
    }
}
