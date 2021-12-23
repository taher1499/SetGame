//
//  Diamond.swift
//  Set
//
//  Created by Taher Poonawala on 21/06/21.
//

import SwiftUI


struct Diamond: Shape {
        
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let Edgelength = CGFloat(min(rect.height,rect.width)/2)
        let CornerA = CGPoint(
            x: centre.x + sqrt(3)*Edgelength, y: centre.y)
        let CornerB = CGPoint(
            x: centre.x, y: centre.y + Edgelength)
        let CornerC = CGPoint(
            x: centre.x - sqrt(3)*Edgelength, y: centre.y)
        let CornerD = CGPoint(
            x: centre.x, y: centre.y - Edgelength)
        
        p.move(to: CornerA)
        p.addLine(to: CornerB)
        p.addLine(to: CornerC)
        p.addLine(to: CornerD)
        p.addLine(to: CornerA)
        
        return p
        
    }
}

