//
//  Piece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Piece {
    
    //creates a new piece of type either BlockPiece or ActivePiece
    class func createNewPiece() -> Piece {
        let randomForType = Int(arc4random_uniform(2))+1//Int(arc4random_uniform(3))
        switch randomForType {
        case 0:
            return BlockPiece()
        case 1:
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
    
    func isABlock() -> Bool {
        return self is BlockPiece
    }
    
    func isComplete() -> Bool {
        if self is ActivePiece {
            return (self as ActivePiece).isComplete()
        }
        return false
    }
    
    //TODO possible function should be overriden instead of calling the subs method here
    func canBeCombinedWithPiece(piece: Piece) -> Bool {
        if !(self is ActivePiece) || !(piece is ActivePiece) {
            return false
        }
        return (self as ActivePiece).canBeCombinedWithActivePiece(piece as ActivePiece)
    }
    
    func combineWithPiece(piece: Piece) {
        assert(self is ActivePiece && piece is ActivePiece, "These pieces cannot be combined, before calling this method call canBeCombinedWithPiece to check.")
        (self as ActivePiece).combineWithActivePiece(piece as ActivePiece)
    }
}