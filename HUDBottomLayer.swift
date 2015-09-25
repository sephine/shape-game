//
//  MenuLayer.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/30/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class HUDBottomLayer: CCNodeColor {
    
    init(size: CGSize) {
        let menuButton = CCButton.buttonWithTitle("Menu", fontName: "Helvetica", fontSize: 20) as! CCButton
        menuButton.position = CGPoint(x: size.width - 10, y: size.height - 5)
        menuButton.anchorPoint = CGPoint(x: 1, y: 1)
        menuButton.label.horizontalAlignment = CCTextAlignment.Right
        menuButton.label.verticalAlignment = CCVerticalTextAlignment.Top
        menuButton.color = CCColor.whiteColor()
        menuButton.label.adjustsFontSizeToFit = true
        
        let backgroundColor = CCColor.blackColor()
        super.init(color: backgroundColor, width: GLfloat(size.width), height: GLfloat(size.height))
        
        self.contentSize = size
        self.userInteractionEnabled = true
        
        menuButton.setTarget(self, selector:"menuButtonClicked")
        self.addChild(menuButton, z: 310)
    }
    
    func menuButtonClicked() {
        let scene = CCDirector.sharedDirector().runningScene as! GameScene
        scene.addMenuLayer(false)
    }
}