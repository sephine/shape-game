//
//  ShapePiece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class ActivePiece: Piece, NSCoding {
    let shape: Shape
    let color: Color
    
    init(shape: Shape, color: Color) {
        self.shape = shape
        self.color = color
        super.init()
    }
    
    required init(coder: NSCoder) {
        self.shape = Shape(rawValue: coder.decodeIntegerForKey(Constants.activePieceShapeKey))!
        self.color = Color(rawValue: coder.decodeIntegerForKey(Constants.activePieceColorKey))!
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(shape.rawValue, forKey: Constants.activePieceShapeKey)
        aCoder.encodeInteger(color.rawValue, forKey: Constants.activePieceColorKey)
    }
    
    override func canBeCombinedWithPiece(piece: Piece) -> Bool {
        if piece is SpecialPiece {
            return true
        } else if piece is ActivePiece {
            return getResultIfPossibleWhenCombinedWithActivePiece(piece as ActivePiece).isPossible
        }
        return false
    }
    
    override func getResultWhencombinedWithPiece(piece: Piece) -> Piece {
        if piece is SpecialPiece {
            let specialPiece = piece as SpecialPiece
            return ActivePiece(shape: specialPiece.shape, color: self.color)
        }
        assert(piece is ActivePiece, "These pieces cannot be combined, before calling this method call canBeCombinedWithActivePiece to check.")
        let isPossibleAndResult = getResultIfPossibleWhenCombinedWithActivePiece(piece as ActivePiece)
        assert(isPossibleAndResult.isPossible, "These pieces cannot be combined, before calling this method call canBeCombinedWithActivePiece to check.")
            
        return isPossibleAndResult.result!
    }
    
    override func getScoreValue() -> Int {
            return 10
    }
    
    private func getResultIfPossibleWhenCombinedWithActivePiece(piece: ActivePiece) ->
        (isPossible: Bool, result: Piece?) {
        
        if self.shape != piece.shape {
            return (isPossible: false, result: nil)
        }
        
        switch self.color {
        case .Blue:
            switch piece.color {
            case .Yellow:
                return (isPossible: true, result: ActivePiece(shape: self.shape, color: .Green))
            case .Red:
                return (isPossible: true, result: ActivePiece(shape: self.shape, color: .Purple))
            case .Orange:
                return (isPossible: true, result: SpecialPiece(shape: self.shape))
            default:
                return (isPossible: false, result: nil)
            }
        case .Yellow:
            switch piece.color {
            case .Blue:
                return (isPossible: true, result: ActivePiece(shape: self.shape, color: .Green))
            case .Red:
                return (isPossible: true, result: ActivePiece(shape: self.shape, color: .Orange))
            case .Purple:
                return (isPossible: true, result: SpecialPiece(shape: self.shape))
            default:
                return (isPossible: false, result: nil)
            }
        case .Red:
            switch piece.color {
            case .Blue:
                return (isPossible: true, result: ActivePiece(shape: self.shape, color: .Purple))
            case .Yellow:
                return (isPossible: true, result: ActivePiece(shape: self.shape, color: .Orange))
            case .Green:
                return (isPossible: true, result: SpecialPiece(shape: self.shape))
            default:
                return (isPossible: false, result: nil)
            }
        case .Green:
            switch piece.color {
            case .Red:
                return (isPossible: true, result: SpecialPiece(shape: self.shape))
            default:
                return (isPossible: false, result: nil)
            }
        case .Purple:
            switch piece.color {
            case .Yellow:
                return (isPossible: true, result: SpecialPiece(shape: self.shape))
            default:
                return (isPossible: false, result: nil)
            }
        case .Orange:
            switch piece.color {
            case .Blue:
                return (isPossible: true, result: SpecialPiece(shape: self.shape))
            default:
                return (isPossible: false, result: nil)
            }
        }
    }
}