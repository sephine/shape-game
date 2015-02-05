//
//  BlockPiece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SpecialPiece: Piece, NSCoding {
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
    
    override func canBeCombinedWithPiece(piece: Piece) -> Bool {
        if piece is ActivePiece {
            return true
        }
        return false
    }
    
    override func getResultWhencombinedWithPiece(piece: Piece) -> Piece {
        assert(piece is ActivePiece, "These pieces cannot be combined, before calling this method call canBeCombinedWithActivePiece to check.")
        let activePiece = piece as ActivePiece
        return ActivePiece(shape: self.shape, color: activePiece.color)
    }
    
    override func getScoreValue() -> Int {
        return 50
    }
}