//
//  IntroScene.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class MainScene: CCScene {
    
    override func onEnter() {
        super.onEnter()
        let size = CCDirector.sharedDirector().viewSize()
        
        //add the launch screen image as the background so there is a seamless transition from the launch screen.
        //TODO is this showing the right resolution image?
        let background = CCSprite.spriteWithImageNamed("Default.png") as CCSprite
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        self.addChild(background)
        self.scheduleOnce("makeTransition", delay: 1)
    }
    
    @objc func makeTransition() {
        CCDirector.sharedDirector().replaceScene(GameScene(), withTransition: CCTransition(fadeWithColor: CCColor.whiteColor(), duration: 1))
    }
    
}