//
//  BlockPieceSprite.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class SpecialPieceSprite: PieceSprite {
    
    init(piece: SpecialPiece) {
        super.init()
        innerSprite = CCSprite.spriteWithImageNamed("active.png") as CCSprite
        self.addChild(innerSprite)
    }
}