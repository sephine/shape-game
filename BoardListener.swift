//
//  BoardListener.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/15/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

protocol BoardListener {
    func pieceCreatedAtPosition(position: BoardPosition, piece: Piece, dropAmount: Int)
    func pieceDeletedAtPosition(position: BoardPosition)
    func pieceMoved(#oldPosition: BoardPosition, newPosition: BoardPosition)
    func pieceColorChangedAtPosition(position: BoardPosition, piece: Piece)
}