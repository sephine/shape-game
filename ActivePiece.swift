//
//  ShapePiece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

enum Shape {
    case Circle, Square
}

enum Color {
    case White, Blue, Yellow, Red, Green, Purple, Orange
}

class ActivePiece: Piece {
    let shape: Shape
    var color: Color
    
    init(shape: Shape, color: Color) {
        self.shape = shape
        self.color = color
        
        super.init()
    }
    
    override func isComplete() -> Bool {
        return self.color == .White
    }
    
    func canBeCombinedWithActivePiece(piece: ActivePiece) -> Bool {
        return findColorIfPossibleWhenCombinedWithNewPiece(piece).isPossible
    }
    
    func combineWithActivePiece(piece: ActivePiece) {
        let isPossibleAndColor = findColorIfPossibleWhenCombinedWithNewPiece(piece)
        assert(isPossibleAndColor.isPossible, "These pieces cannot be combined, before calling this method call canBeCombinedWithActivePiece to check.")
        
        color = isPossibleAndColor.newColor
    }
    
    private func findColorIfPossibleWhenCombinedWithNewPiece(piece: ActivePiece) ->
        (isPossible: Bool, newColor: Color) {
        
        if self.shape != piece.shape {
            return (isPossible: false, newColor: self.color)
        }
        
        switch self.color {
        case .White:
            return (isPossible: false, newColor: .White)
        case .Blue:
            switch piece.color {
            case .Yellow:
                return (isPossible: true, newColor: .Green)
            case .Red:
                return (isPossible: true, newColor: .Purple)
            case .Orange:
                return (isPossible: true, newColor: .White)
            default:
                return (isPossible: false, newColor: .Blue)
            }
        case .Yellow:
            switch piece.color {
            case .Blue:
                return (isPossible: true, newColor: .Green)
            case .Red:
                return (isPossible: true, newColor: .Orange)
            case .Purple:
                return (isPossible: true, newColor: .White)
            default:
                return (isPossible: false, newColor: .Yellow)
            }
        case .Red:
            switch piece.color {
            case .Blue:
                return (isPossible: true, newColor: .Purple)
            case .Yellow:
                return (isPossible: true, newColor: .Orange)
            case .Green:
                return (isPossible: true, newColor: .White)
            default:
                return (isPossible: false, newColor: .Red)
            }
        case .Green:
            switch piece.color {
            case .Red:
                return (isPossible: true, newColor: .White)
            default:
                return (isPossible: false, newColor: .Green)
            }
        case .Purple:
            switch piece.color {
            case .Yellow:
                return (isPossible: true, newColor: .White)
            default:
                return (isPossible: false, newColor: .Purple)
            }
        case .Orange:
            switch piece.color {
            case .Blue:
                return (isPossible: true, newColor: .White)
            default:
                return (isPossible: false, newColor: .Orange)
            }
        }
    }
}