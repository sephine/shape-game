//
//  GameLayer.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/12/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameLayer: CCNodeColor, BoardDelegate {
    
    var spriteLayout: [PieceSprite?]
    let board: Board
    var segmentHeight: Double
    var segmentWidth: Double
    var touchStartPosition: BoardPosition?
    
    init(size: CGSize) {
        
        spriteLayout = [PieceSprite?](count: Constants.numberOfRows*Constants.numberOfColumns, repeatedValue: nil)
        board = Board()
        segmentHeight = Double(ceil(size.height/CGFloat(Constants.numberOfRows)*100)/100)
        segmentWidth = Double(ceil(size.width/CGFloat(Constants.numberOfColumns)*100)/100)
        
        let backgroundColor = CCColor.grayColor()
        super.init(color: backgroundColor, width: GLfloat(size.width), height: GLfloat(size.height))
        
        self.contentSize = size
        self.userInteractionEnabled = true
        
        //add so that the update method in ActionManager is called
        self.addChild(ActionManager.sharedInstance)
        
        board.boardDelegate = self
        board.setUpBoard()
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        let location = touch.locationInNode(self)
        let position = getBoardPositionFromViewPosition(location)
        if boardPositionIsValid(position) {
            touchStartPosition = getBoardPositionFromViewPosition(location)
        } else {
            touchStartPosition = nil
        }
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if touchStartPosition == nil {
            return
        }
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
        
        if boardPositionIsValid(endPosition) &&
            board.canCombinePieceAtStartPositionIntoPieceAtEndPosition(startPosition: touchStartPosition!, endPosition: endPosition) {
            board.combinePieceAtStartPositionIntoPieceAtEndPosition(startPosition: touchStartPosition!, endPosition: endPosition)
        }
    }
    
    func resetGame() {
        board.resetBoard()
    }
    
    func gameOver() {
        
        let action = CCActionCallBlock.actionWithBlock({
            let scene = CCDirector.sharedDirector().runningScene as! GameScene
            scene.addMenuLayer(true)
        }) as! CCActionFiniteTime
        
        ActionManager.sharedInstance.addAction(nil, action: action, isAsync: true)
    }
    
    func pieceCreatedAtPosition(position: BoardPosition, piece: Piece, dropAmount: Int) {
        let newSprite = PieceSprite.createNewSpriteFromPiece(piece) as PieceSprite
        setSpriteAtPosition(position, newSprite: newSprite)
        self.addChild(newSprite)
        newSprite.position = getViewPositionFromBoardPosition(BoardPosition(row: position.row + dropAmount, column: position.column))
        if (dropAmount != 0) {
            let action = CCActionMoveTo.actionWithDuration(0.25, position: getViewPositionFromBoardPosition(position)) as! CCActionFiniteTime
            ActionManager.sharedInstance.addAction(newSprite, action: action, isAsync: false)
        }
    }
    
    //any moves given will be animated simulaneously, otherwise seperate calls result in each not being animated until the last is finished.
    func pieceMoved(#oldPosition: BoardPosition, newPosition: BoardPosition) {
        
        let movingSprite = getSpriteAtPosition(oldPosition)!
        setSpriteAtPosition(oldPosition, newSprite: nil)
        setSpriteAtPosition(newPosition, newSprite: movingSprite)
        let action = CCActionMoveTo.actionWithDuration(0.25, position: getViewPositionFromBoardPosition(newPosition)) as! CCActionFiniteTime
        ActionManager.sharedInstance.addAction(movingSprite, action: action, isAsync: false)
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
        movingSprite.zOrder = 10
        let movingAction = CCActionMoveTo.actionWithDuration(0.25, position: getViewPositionFromBoardPosition(newPosition)) as! CCActionFiniteTime
        ActionManager.sharedInstance.addAction(movingSprite, action: movingAction, isAsync: true)
        
        //remove hidden sprite
        let removeAction = CCActionRemove.action() as! CCActionFiniteTime
        ActionManager.sharedInstance.addAction(stationarySprite, action: removeAction, isAsync: true)
        
        //fade the remaining sprite out and the new one in
        let fadeOutAction = CCActionSequence.actionOne(CCActionFadeOut.actionWithDuration(0.125) as! CCActionFiniteTime, two: CCActionRemove.action() as! CCActionFiniteTime) as! CCActionFiniteTime
        ActionManager.sharedInstance.addAction(movingSprite, action: fadeOutAction, isAsync: true)
        
        let fadeInAction = CCActionFadeIn.actionWithDuration(0.125) as! CCActionFiniteTime
        ActionManager.sharedInstance.addAction(newSprite, action: fadeInAction, isAsync: true)
    }
    
    func pieceDeletedAtPosition(position: BoardPosition) {
        let spriteToRemove = getSpriteAtPosition(position)
        spriteToRemove?.removeFromParent()
    }
    
    private func getSpriteAtPosition(position: BoardPosition) -> PieceSprite? {
        let arrayIndex = (position.row - 1)*Constants.numberOfColumns + (position.column - 1)
        return spriteLayout[arrayIndex]!
    }
    
    private func setSpriteAtPosition(position: BoardPosition, newSprite: PieceSprite?) {
        let arrayIndex = (position.row - 1)*Constants.numberOfColumns + (position.column - 1)
        spriteLayout[arrayIndex] = newSprite
    }
    
    //view positions are used as the position of the center of a sprite.
    private func getViewPositionFromBoardPosition(position: BoardPosition) -> CGPoint {
        let x = (Double(position.column) - 0.5)*segmentWidth
        let y = (Double(position.row) - 0.5)*segmentHeight
        return CGPoint(x: x, y: y)
    }
    
    private func getBoardPositionFromViewPosition(point: CGPoint) -> BoardPosition {
        let column = Int(point.x/CGFloat(segmentWidth)) + 1
        let row = Int(point.y/CGFloat(segmentHeight)) + 1
        return BoardPosition(row: row, column: column)
    }
    
    private func boardPositionIsValid(position: BoardPosition) -> Bool {
        if position.row >= 1 && position.row <= Constants.numberOfRows && position.column >= 1 && position.column <= Constants.numberOfColumns {
            return true
        }
        return false
    }
}