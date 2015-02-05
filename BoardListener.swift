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
    func pieceMoved(#oldPosition: BoardPosition, newPosition: BoardPosition)
    func pieceMovedAndNewPieceCreated(#oldPosition: BoardPosition, newPosition: BoardPosition, newPiece: Piece)
    func pieceDeletedAtPosition(position: BoardPosition)
    func gameOver()
}