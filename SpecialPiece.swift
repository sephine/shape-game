//
//  BlockPiece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SpecialPiece: Piece {
    override func canBeCombinedWithPiece(piece: Piece) -> Bool {
        if piece is ActivePiece {
            return true
        }
        return false
    }
    
    override func getResultWhencombinedWithPiece(piece: Piece) -> Piece {
        assert(piece is ActivePiece, "These pieces cannot be combined, before calling this method call canBeCombinedWithActivePiece to check.")
        let activePiece = piece as ActivePiece
        if activePiece.shape == .Circle {
            return ActivePiece(shape: .Square, color: activePiece.color)
        }
        return ActivePiece(shape: .Circle, color: activePiece.color)
    }
}