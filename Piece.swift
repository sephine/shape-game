//
//  Piece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

enum Shape {
    case Circle, Square
}

enum Color {
    case Blue, Yellow, Red, Green, Purple, Orange
}

class Piece {
    
    class func createNewPiece() -> Piece {
        let randomForType = Int(arc4random_uniform(2))
        switch randomForType {
        case 0:
            let randomForColor = Int(arc4random_uniform(3))
            switch randomForColor {
            case 0:
                return ActivePiece(shape: .Circle, color: .Blue)
            case 1:
                return ActivePiece(shape: .Circle, color: .Yellow)
            default:
                return ActivePiece(shape: .Circle, color: .Red)
            }
        default:
            let randomForColor = Int(arc4random_uniform(3))
            switch randomForColor {
            case 0:
                return ActivePiece(shape: .Square, color: .Blue)
            case 1:
                return ActivePiece(shape: .Square, color: .Yellow)
            default:
                return ActivePiece(shape: .Square, color: .Red)
            }
        }
    }
    
    func canBeCombinedWithPiece(piece: Piece) -> Bool {
        return false
    }
    
    func getResultWhencombinedWithPiece(piece: Piece) -> Piece {
        assertionFailure("An instance of the Piece class has been created, only instances of it's subclasses should exist")
    }
}