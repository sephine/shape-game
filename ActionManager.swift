//
//  ActionManager.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

//singleton class
class ActionManager: CCNode {
    class var sharedInstance: ActionManager {
        struct Static {
            static let instance: ActionManager = ActionManager()
        }
        return Static.instance
    }
    
    private var actionQueue: [(sprite: PieceSprite, action: CCActionFiniteTime, isAsync: Bool)] = []
    
    private override init() {
        //must use shared instance property to get singleton.
        
    }
    
    func addAction(sprite: PieceSprite, action: CCActionFiniteTime, isAsync: Bool) {
        let actionTuple = (sprite: sprite, action: action, isAsync: isAsync)
        actionQueue.append(actionTuple)
        checkForRunableActions()
    }
    
    func checkForRunableActions() {
        var firstItem = true
        for item in actionQueue {
            if !item.action.isDone() && item.sprite.numberOfRunningActions() == 0 && (firstItem || !item.isAsync) {
                item.sprite.runAction(item.action)
            }
            if item.isAsync {
                break
            }
            firstItem = false
        }
    }
    
    override func update(delta: CCTime) {
        for var i = 0; i<actionQueue.count; i++ {
            if actionQueue[i].action.isDone() {
                actionQueue.removeAtIndex(i)
                checkForRunableActions()
            }
        }
    }
}