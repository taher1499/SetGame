//
//  SetView.swift
//  Set
//
//  Created by Taher Poonawala on 20/06/21.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var viewmodel: SetViewModel
    var body: some View {
        VStack{
            Text("Sets Found: \(viewmodel.score)")
                .font(.title)
                .fontWeight(.heavy)
            
            AspectVGrid(items: Array(viewmodel.cards[0..<viewmodel.NumberofCardstoDisplay]), aspectRatio: 2/3)
            {card in
                
                if card.isPartofSet{
                        CardView(card: card).opacity(0)
                }
                
                else {
                CardView(card: card)
                .onTapGesture {
                        viewmodel.pick(card)
                    }
                }
            }
        
            Button(action: {viewmodel.IncreaseNumberofDisplayedCards()}
                   , label: {
                    VStack{
                        Text("More Cards")
                        Image(systemName: "plus.circle")
                    }.font(.largeTitle)
            })
            
        }
    }
}

struct CardView: View {
    
    var card: SetGame<Color>.Card
    
    let shape = RoundedRectangle(cornerRadius: 15)
   
    var body: some View {
        ZStack{
            if card.isSelected{
                shape.stroke(lineWidth: 3).foregroundColor(.none)
                shape.foregroundColor(.yellow).opacity(0.4)
                ChooseCorrectShape(card: card)
            }
            
            else if card.isPartofSet{
                shape.stroke(lineWidth: 3).foregroundColor(.none)
                shape.foregroundColor(.blue).opacity(0.4)
                ChooseCorrectShape(card: card)
                
            }
            
            else {
                shape.stroke(lineWidth: 3).foregroundColor(.none)
                shape.foregroundColor(.white)
                ChooseCorrectShape(card: card)
            }
            
        }.foregroundColor(card.color)
     
    }
    
    
    @ViewBuilder
    func ChooseCorrectShape(card: SetGame<Color>.Card)-> some View {
        if card.shape == .diamond{
            ReturnNumberofShape(shape: Diamond(), number: card.number)
        }

        if card.shape == .capsule{
            ReturnNumberofShape(shape: Capsule(style: .circular), number: card.number)
        }

        if card.shape == .rectangle{
            ReturnNumberofShape(shape: Rectangle(), number: card.number)
        }
    
    }
    
    @ViewBuilder
    func ReturnNumberofShape<T: Shape>(shape: T, number: SetGame<Color>.ObjectNumber)-> some View {
        if number == .one {
            returnShadedShape(shape: shape.scale(0.5), card: card)
        }
        if number == .two {
            VStack{
                returnShadedShape(shape: shape
                                  , card: card)
                returnShadedShape(shape: shape
                                  , card: card)
            }.padding()
        }
        if number == .three {
            VStack{
            returnShadedShape(shape: shape, card: card)
            returnShadedShape(shape: shape, card: card)
            returnShadedShape(shape: shape, card: card)
            }.padding()
        }
    }
    
    @ViewBuilder
    func returnShadedShape<T: Shape> (shape:T, card: SetGame<Color>.Card)-> some View{
        if card.shading == .open{
            shape.stroke(lineWidth: 3).aspectRatio(0.7,contentMode: .fit)
        }
        if card.shading == .solid{
            shape.fill().aspectRatio(0.7,contentMode: .fit)
        }
        if card.shading == .striped {
            shape.opacity(0.4).aspectRatio(0.7,contentMode: .fit)
        }
    }

    
}





















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let games = SetViewModel()
        SetView(viewmodel: games)
    }
}

