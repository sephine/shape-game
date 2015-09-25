//
//  PieceFactory.swift
//  ShapeGame
//
//  Created by Joanne Maynard on 9/22/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class PieceFactory: NSObject {
    
    class func createNewPiece() -> Piece {
        let randomForType = Int(arc4random_uniform(3))
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
        case 1:
            let randomForColor = Int(arc4random_uniform(3))
            switch randomForColor {
            case 0:
                return ActivePiece(shape: .Square, color: .Blue)
            case 1:
                return ActivePiece(shape: .Square, color: .Yellow)
            default:
                return ActivePiece(shape: .Square, color: .Red)
            }
        default:
            let randomForColor = Int(arc4random_uniform(3))
            switch randomForColor {
            case 0:
                return ActivePiece(shape: .Triangle, color: .Blue)
            case 1:
                return ActivePiece(shape: .Triangle, color: .Yellow)
            default:
                return ActivePiece(shape: .Triangle, color: .Red)
            }
        }
    }
}