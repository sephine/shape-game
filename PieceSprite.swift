//
//  PieceSprite.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class PieceSprite: CCNode {
    
    var innerSprite = CCSprite()
    /*override var opacity: CGFloat {
        get {
            return innerSprite.opacity
        }
        set {
            innerSprite.opacity = newValue
        }
    }*/
    
    //should not be called directly, should only be called by subclasses
    override init() {
        super.init()
        self.cascadeOpacityEnabled = true
    }

    class func createNewSpriteFromPiece(piece: Piece) -> PieceSprite {
        if piece is ActivePiece {
            return ActivePieceSprite(piece: piece as ActivePiece)
        }
        return SpecialPieceSprite(piece: piece as SpecialPiece)
    }
}