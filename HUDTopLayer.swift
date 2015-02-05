//
//  HUDLayer.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/29/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class HUDTopLayer: CCNodeColor {
    
    var displayedScore: Int
    var scoreLabel: CCLabelTTF
    
    init(size: CGSize) {
        displayedScore = GameData.sharedInstance.score
        scoreLabel = CCLabelTTF.labelWithString("Score: \(displayedScore)", fontName: "Helvetica", fontSize: 20, dimensions: CGSize(width: 140, height: 24)) as CCLabelTTF
        scoreLabel.position = CGPoint(x: 10, y: 5)
        scoreLabel.anchorPoint = CGPoint(x: 0, y: 0)
        scoreLabel.horizontalAlignment = CCTextAlignment.Left
        scoreLabel.verticalAlignment = CCVerticalTextAlignment.Bottom
        scoreLabel.color = CCColor.whiteColor()
        
        let backgroundColor = CCColor.blackColor()
        super.init(color: backgroundColor, width: GLfloat(size.width), height: GLfloat(size.height))
        
        self.contentSize = size
        self.userInteractionEnabled = true
        
        self.addChild(scoreLabel, z: 210)
    }
    
    override func update(delta: CCTime) {
        let currentScore = GameData.sharedInstance.score
        if currentScore != displayedScore {
            displayedScore = currentScore
            scoreLabel.string = "Score - \(displayedScore)"
        }
    }
}