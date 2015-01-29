//
//  GameLayer.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameLayer: CCNodeColor, BoardListener {
    
    var spriteLayout: [PieceSprite?]
    let board: Board
    var segmentHeight: Double
    var segmentWidth: Double
    var touchStartPosition: BoardPosition?
    
    override init() {
        
        board = Board()
        spriteLayout = [PieceSprite?](count: Constants.numberOfRows*Constants.numberOfColumns, repeatedValue: nil)
        
        let size = CCDirector.sharedDirector().viewSize()
        segmentHeight = Double(ceil(size.height/CGFloat(Constants.numberOfRows)*100)/100)
        segmentWidth = Double(ceil(size.width/CGFloat(Constants.numberOfColumns)*100)/100)
        let backgroundColor = CCColor.whiteColor()
        super.init(color: backgroundColor, width: GLfloat(size.width), height: GLfloat(size.height))
        board.listener = self
        
        self.contentSize = size
        self.userInteractionEnabled = true
        
        //add so that the update method in ActionManager is called
        self.addChild(ActionManager.sharedInstance)
        
        startNewGame()
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        let location = touch.locationInNode(self)
        touchStartPosition = getBoardPositionFromViewPosition(location)
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        let location = touch.locationInNode(self)
        let touchPosition = getBoardPositionFromViewPosition(location)
        var endRow, endColumn: Int
        if touchPosition.row == touchStartPosition!.row {
            if touchPosition.column < touchStartPosition!.column {
                endRow = touchStartPosition!.row
                endColumn = touchStartPosition!.column - 1
            } else if touchPosition.column > touchStartPosition!.column {
                endRow = touchStartPosition!.row
                endColumn = touchStartPosition!.column + 1
            } else {
                return
            }
        } else if touchPosition.column == touchStartPosition!.column {
            if touchPosition.row < touchStartPosition!.row {
                endRow = touchStartPosition!.row - 1
                endColumn = touchStartPosition!.column
            } else {
                endRow = touchStartPosition!.row + 1
                endColumn = touchStartPosition!.column
            }
        } else {
            return
        }
        let endPosition = BoardPosition(row: endRow, column: endColumn)
        
        if board.canCombinePieceAtStartPositionIntoPieceAtEndPosition(startPosition: touchStartPosition!, endPosition: endPosition) {
            board.combinePieceAtStartPositionIntoPieceAtEndPosition(startPosition: touchStartPosition!, endPosition: endPosition)
        }
    }
    
    func startNewGame() {
        board.fillBoard()
    }
    
    func pieceCreatedAtPosition(position: BoardPosition, piece: Piece, dropAmount: Int) {
        let newSprite = PieceSprite.createNewSpriteFromPiece(piece) as PieceSprite
        setSpriteAtPosition(position, newSprite: newSprite)
        self.addChild(newSprite)
        newSprite.position = getViewPositionFromBoardPosition(BoardPosition(row: position.row + dropAmount, column: position.column))
        if (dropAmount != 0) {
            let action = CCActionMoveTo.actionWithDuration(0.25, position: getViewPositionFromBoardPosition(position)) as CCActionFiniteTime
            ActionManager.sharedInstance.addAction(newSprite, action: action, isAsync: false)
        }
    }
    
    
    //any moves given will be animated simulaneously, otherwise seperate calls result in each not being animated until the last is finished.
    func pieceMoved(#oldPosition: BoardPosition, newPosition: BoardPosition) {
        
        let movingSprite = getSpriteAtPosition(oldPosition)!
        setSpriteAtPosition(oldPosition, newSprite: nil)
        setSpriteAtPosition(newPosition, newSprite: movingSprite)
        let action = CCActionMoveTo.actionWithDuration(0.25, position: getViewPositionFromBoardPosition(newPosition)) as CCActionFiniteTime
        ActionManager.sharedInstance.addAction(movingSprite, action: action, isAsync: false)
        //movingSprite.position = getViewPositionFromBoardPosition(newPosition)
    }
    
    func pieceMovedAndNewPieceCreated(#oldPosition: BoardPosition, newPosition: BoardPosition, newPiece: Piece) {
        let movingSprite = getSpriteAtPosition(oldPosition)!
        let stationarySprite = getSpriteAtPosition(newPosition)!
        let newSprite = PieceSprite.createNewSpriteFromPiece(newPiece) as PieceSprite
        newSprite.position = stationarySprite.position
        newSprite.opacity = 0
        self.addChild(newSprite)
        setSpriteAtPosition(oldPosition, newSprite: nil)
        setSpriteAtPosition(newPosition, newSprite: newSprite)
        
        //move sprite onto other sprite
        movingSprite.zOrder = 100
        let movingAction = CCActionMoveTo.actionWithDuration(0.25, position: getViewPositionFromBoardPosition(newPosition)) as CCActionFiniteTime
        ActionManager.sharedInstance.addAction(movingSprite, action: movingAction, isAsync: true)
        
        //remove hidden sprite
        let removeAction = CCActionSequence.actionOne(CCActionFadeOut.actionWithDuration(0.001) as CCActionFiniteTime, two: CCActionRemove.action() as CCActionFiniteTime) as CCActionFiniteTime
        ActionManager.sharedInstance.addAction(stationarySprite, action: removeAction, isAsync: true)
        
        //fade the remaining sprite out and the new one in
        let fadeOutAction = CCActionSequence.actionOne(CCActionFadeOut.actionWithDuration(0.125) as CCActionFiniteTime, two: CCActionRemove.action() as CCActionFiniteTime) as CCActionFiniteTime
        ActionManager.sharedInstance.addAction(movingSprite, action: fadeOutAction, isAsync: true)
        
        let fadeInAction = CCActionFadeIn.actionWithDuration(0.125) as CCActionFiniteTime
        ActionManager.sharedInstance.addAction(newSprite, action: fadeInAction, isAsync: true)
    }
    
    private func getSpriteAtPosition(position: BoardPosition) -> PieceSprite? {
        let arrayIndex = (position.row - 1)*Constants.numberOfColumns + (position.column - 1)
        return spriteLayout[arrayIndex]!
    }
    
    private func setSpriteAtPosition(position: BoardPosition, newSprite: PieceSprite?) {
        let arrayIndex = (position.row - 1)*Constants.numberOfColumns + (position.column - 1)
        spriteLayout[arrayIndex] = newSprite
        //spriteLayout.insert(newSprite, atIndex: arrayIndex)
    }
    
    //view positions are used as the position of the center of a sprite.
    private func getViewPositionFromBoardPosition(position: BoardPosition) -> CGPoint {
        let x = (Double(position.column) - 0.5)*segmentWidth
        let y = (Double(position.row) - 0.5)*segmentHeight //+28  64 224    384x568   image 56x56
        return CGPoint(x: x, y: y)
    }
    
    private func getBoardPositionFromViewPosition(point: CGPoint) -> BoardPosition {
        let column = Int(point.x/CGFloat(segmentWidth)) + 1
        let row = Int(point.y/CGFloat(segmentHeight)) + 1
        return BoardPosition(row: row, column: column)
        //TODO might need to be altered based on 32 offset
    }
}