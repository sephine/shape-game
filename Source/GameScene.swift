import Foundation

class GameScene: CCScene {
    override init() {
        super.init()
        
        let gameLayer = GameLayer()
        self.addChild(gameLayer, z: 90)
    }
}
