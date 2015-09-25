//
//  BlockPiece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SpecialPiece: NSObject, Piece {
    let shape: Shape
    
    init(shape: Shape) {
        self.shape = shape
        super.init()
    }
    
    required init(coder: NSCoder) {
        self.shape = Shape(rawValue: coder.decodeIntegerForKey(Constants.specialPieceShapeKey))!
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(shape.rawValue, forKey: Constants.specialPieceShapeKey)
    }
    
    func canBeCombinedWithPiece(piece: Piece) -> Bool {
        if piece is ActivePiece {
            return true
        }
        return false
    }
    
    func getResultWhencombinedWithPiece(piece: Piece) -> Piece {
        assert(piece is ActivePiece, "These pieces cannot be combined, before calling this method call canBeCombinedWithActivePiece to check.")
        let activePiece = piece as! ActivePiece
        return ActivePiece(shape: self.shape, color: activePiece.color)
    }
    
    func getScoreValue() -> Int {
        return 50
    }
}