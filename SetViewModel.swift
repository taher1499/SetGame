//
//  SetViewModel.swift
//  Set
//
//  Created by Taher Poonawala on 20/06/21.
//

import SwiftUI

class SetViewModel: ObservableObject {
    
    static let Colors: Array<Color> = [.red,.green,.purple]
    
        @Published var model = SetGame<Color>(Colors)
        
        var cards: Array<SetGame<Color>.Card> {
            model.cards
                .filter({card in card.isPartofSet==false})
        }
        
        var NumberofCardstoDisplay: Int {
            model.NumberOfCardstoDisplay
        }
    
    var score: Int {
        model.SetsFound
        
    }
    
    //MARK: Intents
    
    func IncreaseNumberofDisplayedCards() {
        model.IncreaseNumberofDisplayedCards()
    }
    
    func pick(_ card: SetGame<Color>.Card){
        model.pick(card)
    }

}
