//
//  BlockPiece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SpecialPiece: Piece {
    let shape: Shape
    
    init(shape: Shape) {
        self.shape = shape
        super.init()
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
}