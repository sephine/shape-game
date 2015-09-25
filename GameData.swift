//
//  Game Data.swift
//  ShapeGame
//
//  Created by Joanne Dyer on 1/29/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    var boardLayout = [Piece]()
    var score = 0
    
    class var filePath: String {
        struct StaticPath {
            static let path = GameData.getFilePath()
        }
        return StaticPath.path
    }
    
    class var sharedInstance: GameData {
        struct StaticInstance {
            static let instance = GameData.loadInstance()
        }
        return StaticInstance.instance
    }
    
    private override init() {
        //must use shared instance property to get singleton.
        super.init()
    }
    
    required init(coder: NSCoder) {
        self.boardLayout = coder.decodeObjectForKey(Constants.gameDataBoardLayoutKey) as! [Piece]
        self.score = coder.decodeIntegerForKey(Constants.gameDataScoreKey)
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.boardLayout, forKey: Constants.gameDataBoardLayoutKey)
        aCoder.encodeInteger(self.score, forKey: Constants.gameDataScoreKey)
    }
    
    func save() {
        let success = NSKeyedArchiver.archiveRootObject(self, toFile: GameData.filePath)
        let i = 0
    }
    
    class func getFilePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!.stringByAppendingString(Constants.gameDataKey)
    }
    
    class func loadInstance() -> GameData {
        let path = filePath
        if let gameData = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? GameData {
            return gameData
        }
        return GameData()
    }
}