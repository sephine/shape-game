//
//  ActivePieceSprite.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation
import SpriteKit

class ActivePieceSprite: PieceSprite {
    
    init(piece: ActivePiece) {
        super.init()
        setInnerSpriteToMatchPiece(piece)
        self.addChild(innerSprite)
    }
    
    private func setInnerSpriteToMatchPiece(piece: ActivePiece) {
        switch piece.shape {
        case .Circle:
            switch piece.color {
            case .Blue:
                innerSprite = CCSprite.spriteWithImageNamed("BlueCircle.png") as CCSprite
            case .Yellow:
                innerSprite = CCSprite.spriteWithImageNamed("YellowCircle.png") as CCSprite
            case .Red:
                innerSprite = CCSprite.spriteWithImageNamed("RedCircle.png") as CCSprite
            case .Green:
                innerSprite = CCSprite.spriteWithImageNamed("GreenCircle.png") as CCSprite
            case .Purple:
                innerSprite = CCSprite.spriteWithImageNamed("PurpleCircle.png") as CCSprite
            case .Orange:
                innerSprite = CCSprite.spriteWithImageNamed("OrangeCircle.png") as CCSprite
            }
        case .Square:
            switch piece.color {
            case .Blue:
                innerSprite = CCSprite.spriteWithImageNamed("BlueSquare.png") as CCSprite
            case .Yellow:
                innerSprite = CCSprite.spriteWithImageNamed("YellowSquare.png") as CCSprite
            case .Red:
                innerSprite = CCSprite.spriteWithImageNamed("RedSquare.png") as CCSprite
            case .Green:
                innerSprite = CCSprite.spriteWithImageNamed("GreenSquare.png") as CCSprite
            case .Purple:
                innerSprite = CCSprite.spriteWithImageNamed("PurpleSquare.png") as CCSprite
            case .Orange:
                innerSprite = CCSprite.spriteWithImageNamed("OrangeSquare.png") as CCSprite
            }
        }
    }
}