//
//  MemoryGame.swift
//  SwiftUI-MemorizeApp (iOS)
//
//  Created by Wei Lun Hsu on 2022/3/21.
//

import Foundation

/// T 需要符合 `Equatable` 才可以比較 Card 是否相等
struct MemoryGame<T> where T: Equatable {
    
    /// 外部只能 `Get`
    private(set) var cards: [Card]
    
    ///
    private var previousIndex: Int?
    
    init(numberOfPairsOfCard: Int, createCardContent: (Int) -> T) {
        cards = []
        
        for pairIndex in 0 ..< numberOfPairsOfCard {
            cards.append(.init(id: pairIndex * 2, content: createCardContent(pairIndex)))
            cards.append(.init(id: pairIndex * 2 + 1, content: createCardContent(pairIndex)))
        }
    }
    
    mutating func choose(_ card: Card) {
        
        if let index = cards.firstIndex(where: { $0.id == card.id }),
           !cards[index].isFaceUp,
           !cards[index].isMatched
        {
            /// 如果有上一張卡片則進行比較
            if let previousIndex = previousIndex {
                
                if cards[index].content == cards[previousIndex].content {
                    cards[index].isMatched = true
                    cards[previousIndex].isMatched = true
                }
                self.previousIndex = nil
            } else {
                cards.indices.forEach {
                    cards[$0].isFaceUp = false
                }
                
                self.previousIndex = index
            }
            
            cards[index].isFaceUp.toggle()
        }
    }
    
//    private func index(of card: Card) -> Int {
//        for (i, item) in cards.enumerated() {
//            if item.id == card.id {
//                return i
//            }
//        }
//        return -1
//    }
    
    struct Card: Identifiable {
        
        var id: Int
        
        var isFaceUp: Bool = false
         
        var isMatched: Bool = false
        
        var content: T
    }
}
