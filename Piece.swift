//
//  Piece.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

enum Shape: Int {
    case Circle, Square, Triangle
}

enum Color: Int {
    case Blue, Yellow, Red, Green, Purple, Orange
}

@objc protocol Piece: class, NSCoding {
    func canBeCombinedWithPiece(piece: Piece) -> Bool
    func getResultWhencombinedWithPiece(piece: Piece) -> Piece
    func getScoreValue() -> Int
}