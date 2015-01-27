//
//  PieceSprite.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class PieceSprite: CCNode {

    class func createNewSpriteFromPiece(piece: Piece) -> PieceSprite {
        if piece is ActivePiece {
            return ActivePieceSprite(piece: piece as ActivePiece)
        }
        return BlockPieceSprite(piece: piece as BlockPiece)
    }
    
    func changeColorToColorOfPiece(piece: Piece) {
        //this method only has an effect for ActivePieceSprites where it has been overwritten.
    }
    
    //func pieceDeleted() {
    //    self.removeFromParent()
    //}
}