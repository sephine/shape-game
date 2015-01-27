import Foundation

class GameScene: CCScene {
    override init() {
        super.init()
        
        let gameLayer = GameLayer(numberOfRows: 9, numberOfColumns: 7)
        self.addChild(gameLayer, z: 90)
    }
}
