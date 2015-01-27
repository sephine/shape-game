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
    
    var sprite: CCSprite {
        didSet {
            oldValue.removeFromParent()
            self.addChild(sprite)
        }
    }
    //CCSprite.spriteWithImageNamed("EmptyCircle.png") as CCSprite
    
    init(piece: ActivePiece) {
        sprite = CCSprite()
        super.init()
        changeColorToColorOfPiece(piece)
    }
    
    override func changeColorToColorOfPiece(piece: Piece) {
        assert(piece is ActivePiece, "Requests should only be made to change the color of ActivePieces")
        let activePiece = piece as ActivePiece
        switch activePiece.shape {
        case .Circle:
            switch activePiece.color {
            case .White:
                sprite = CCSprite.spriteWithImageNamed("EmptyCircle.png") as CCSprite
            case .Blue:
                sprite = CCSprite.spriteWithImageNamed("BlueCircle.png") as CCSprite
            case .Yellow:
                sprite = CCSprite.spriteWithImageNamed("YellowCircle.png") as CCSprite
            case .Red:
                sprite = CCSprite.spriteWithImageNamed("RedCircle.png") as CCSprite
            case .Green:
                sprite = CCSprite.spriteWithImageNamed("GreenCircle.png") as CCSprite
            case .Purple:
                sprite = CCSprite.spriteWithImageNamed("PurpleCircle.png") as CCSprite
            case .Orange:
                sprite = CCSprite.spriteWithImageNamed("OrangeCircle.png") as CCSprite
            }
        case .Square:
            switch activePiece.color {
            case .White:
                sprite = CCSprite.spriteWithImageNamed("WhiteSquare.png") as CCSprite
            case .Blue:
                sprite = CCSprite.spriteWithImageNamed("BlueSquare.png") as CCSprite
            case .Yellow:
                sprite = CCSprite.spriteWithImageNamed("YellowSquare.png") as CCSprite
            case .Red:
                sprite = CCSprite.spriteWithImageNamed("RedSquare.png") as CCSprite
            case .Green:
                sprite = CCSprite.spriteWithImageNamed("GreenSquare.png") as CCSprite
            case .Purple:
                sprite = CCSprite.spriteWithImageNamed("PurpleSquare.png") as CCSprite
            case .Orange:
                sprite = CCSprite.spriteWithImageNamed("OrangeSquare.png") as CCSprite
            }
        }
    }
}