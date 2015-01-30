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
        self.boardLayout = coder.decodeObjectForKey(Constants.gameDataBoardLayoutKey) as [Piece]
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(boardLayout, forKey: Constants.gameDataBoardLayoutKey)
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self, toFile: GameData.filePath)
    }
    
    class func getFilePath() -> String {
        return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!.stringByAppendingString(Constants.gameDataKey)
    }
    
    class func loadInstance() -> GameData {
        if let gameData = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? GameData {
            return gameData
        }
        return GameData()
    }
}