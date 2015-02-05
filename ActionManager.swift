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
    
    private var actionQueue: [(sprite: PieceSprite?, action: CCActionFiniteTime, isAsync: Bool)] = []
    
    private override init() {
        //must use shared instance property to get singleton.
        
    }
    
    //use caution when passing nil for sprite, the action may be started more than once
    func addAction(sprite: PieceSprite?, action: CCActionFiniteTime, isAsync: Bool) {
        //instant actions count as automatically being done and so cannot be properly queued unless you change them by adding a delay so they don't count as instant.
        var nonInstantAction = action
        if nonInstantAction is CCActionInstant {
            nonInstantAction = CCActionSequence.actionOne(CCActionDelay.actionWithDuration(0.001) as CCActionFiniteTime, two: action) as CCActionFiniteTime
        }
        let actionTuple = (sprite: sprite, action: nonInstantAction, isAsync: isAsync)
        actionQueue.append(actionTuple)
        checkForRunableActions()
    }
    
    func checkForRunableActions() {
        var firstItem = true
        for item in actionQueue {
            if !item.action.isDone() && (item.sprite == nil || item.sprite!.numberOfRunningActions() == 0) && (firstItem || !item.isAsync) {
                if item.sprite != nil {
                    item.sprite!.runAction(item.action)
                } else {
                    runAction(item.action)
                }
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