//
//  MenuLayer.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 2/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class MenuLayer: CCNodeColor {
    init(gameOver: Bool) {
        let size = CCDirector.sharedDirector().viewSize()
        let backgroundColor = CCColor.blackColor()
        super.init(color: backgroundColor, width: GLfloat(size.width), height: GLfloat(size.height))
        self.opacity = 0.5
        
        let backgroundSquare = CCNodeColor(color: CCColor.blackColor(), width: 140, height: 230)
        backgroundSquare.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundSquare.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let gameOverLabel = CCLabelTTF.labelWithString("Game Over", fontName: "Helvetica", fontSize: 20) as CCLabelTTF
        gameOverLabel.color = CCColor.blueColor()
        let resumeButton = CCButton.buttonWithTitle("Resume", fontName: "Helvetica", fontSize: 20) as CCButton
        let resetButton = CCButton.buttonWithTitle("Reset", fontName: "Helvetica", fontSize: 20) as CCButton
        
        let layoutBox = CCLayoutBox()
        layoutBox.position = CGPoint(x: size.width/2, y: size.height/2)
        layoutBox.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layoutBox.spacing = 15
        layoutBox.direction = CCLayoutBoxDirection.Vertical
        
        layoutBox.addChild(resetButton)
        if gameOver {
            layoutBox.addChild(gameOverLabel)
        } else {
            layoutBox.addChild(resumeButton)
        }
        layoutBox.layout()
        
        self.contentSize = size
        self.userInteractionEnabled = true
        
        self.addChild(backgroundSquare, z: 410)
        
        resumeButton.setTarget(self, selector:"resumeButtonClicked")
        resetButton.setTarget(self, selector:"resetButtonClicked")
        
        self.addChild(layoutBox, z:420)
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        //absorbs touches
    }
    
    func resumeButtonClicked() {
        let scene = CCDirector.sharedDirector().runningScene as GameScene
        scene.resumeGame()
    }
    
    func resetButtonClicked() {
        let scene = CCDirector.sharedDirector().runningScene as GameScene
        scene.resetGame()
    }
}