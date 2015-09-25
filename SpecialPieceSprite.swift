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
        setInnerSpriteToMatchPiece(piece)
        self.addChild(innerSprite)
    }
    
    private func setInnerSpriteToMatchPiece(piece: SpecialPiece) {
        switch piece.shape {
        case .Circle:
            innerSprite = CCSprite.spriteWithImageNamed("WhiteCircle.png") as! CCSprite
        case .Square:
            innerSprite = CCSprite.spriteWithImageNamed("WhiteSquare.png") as! CCSprite
        case .Triangle:
            innerSprite = CCSprite.spriteWithImageNamed("WhiteTriangle.png") as! CCSprite
        }
    }
}