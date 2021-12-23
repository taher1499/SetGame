//
//  SetGame.swift
//  Set
//
//  Created by Taher Poonawala on 20/06/21.
//

import Foundation
import SwiftUI

struct SetGame<CardColor: Equatable> {
    var cards: [Card]
    
    var NumberOfCardstoDisplay = 12
    
    var SetsFound = 0
    
    var IndicesofCardsthatHaveBeenSelected: [Int?] {
        get {
            cards.indices.filter({cards[$0].isSelected})
            
        }
        set {
            cards.indices.forEach({cards[$0].isSelected=($0==newValue[0])})
            
        }
    }
    
    mutating func pick(_ card: Card) {
        if let chosenindex=cards.firstIndex(where: {$0.id == card.id}), !cards[chosenindex].isPartofSet
       {cards[chosenindex].isSelected.toggle()
        if IndicesofCardsthatHaveBeenSelected.count==3
        {
            let cardshapes = IndicesofCardsthatHaveBeenSelected.map({index in cards[index!].shape})
            let cardcolors = IndicesofCardsthatHaveBeenSelected.map({index in cards[index!].color})
            let cardnumbers = IndicesofCardsthatHaveBeenSelected.map({index in cards[index!].number})
            let cardshadings = IndicesofCardsthatHaveBeenSelected.map({index in cards[index!].shading})
            
            if (cardshapes.allSatisfy({$0 == cardshapes.first}) || ArrayElementsAreDistinct(array: cardshapes)) &&
                (cardcolors.allSatisfy({$0 == cardcolors.first}) || ArrayElementsAreDistinct(array: cardcolors)) &&
                (cardnumbers.allSatisfy({$0 == cardnumbers.first}) || ArrayElementsAreDistinct(array: cardnumbers)) &&
                (cardshadings.allSatisfy({$0 == cardshadings.first}) || ArrayElementsAreDistinct(array: cardshadings))
            {
                IndicesofCardsthatHaveBeenSelected.forEach({cards[$0!].isPartofSet = true})
                SetsFound+=1                
            }
            
            
        }
            if IndicesofCardsthatHaveBeenSelected.count>3{
                IndicesofCardsthatHaveBeenSelected = [chosenindex]

            }
        }
       
       
    }
    
    init(_ cardcolors: Array<CardColor>) {
        cards=[]
        let colors = cardcolors
        let shapes = ObjectShape.allCases
        let numbers = ObjectNumber.allCases
        let styles = ObjectShading.allCases
        var index=0
            for color in colors{
                for shape in shapes{
                    for number in numbers{
                        for style in styles {
                            cards.append(Card(id: index, color: color, shape: shape, number: number, shading: style))
                            index+=1
                        }
                    }
                }
            }
        cards.shuffle()

    }
    
    mutating func IncreaseNumberofDisplayedCards() {
        if NumberOfCardstoDisplay<79 {
            NumberOfCardstoDisplay+=3
        }
    }

    
    struct Card: Identifiable {
        var id: Int
        var color: CardColor
        var shape: ObjectShape
        var number: ObjectNumber
        var shading: ObjectShading
        var isPartofSet: Bool = false
        var isSelected: Bool = false
    }
    

    enum ObjectShading: CaseIterable, Equatable {
        case solid, striped, open
    }
    
    enum ObjectNumber: Int, CaseIterable, Equatable {
        case one = 1, two = 2, three = 3
    }
    
    enum ObjectShape: CaseIterable, Equatable{
        case diamond, capsule, rectangle
    }
    
    func ArrayElementsAreDistinct<T: Equatable>(array: Array<T>)->Bool{
        for element in array{
            let filteredArray = array.filter{$0 == element}
            if filteredArray.count > 1 {
                return false
            }
        }
        return true
    }
    

    
}





