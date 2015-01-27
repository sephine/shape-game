//
//  BlockPieceSprite.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class BlockPieceSprite: PieceSprite {
    
    var sprite = CCSprite.spriteWithImageNamed("active.png") as CCSprite
    
    init(piece: BlockPiece) {
        super.init()
        self.addChild(sprite)
    }
}