import Foundation
import iAd

class GameScene: CCScene {
    
    let gameLayer: GameLayer
    var menuLayer: MenuLayer?
    
    override init() {        
        let size = CCDirector.sharedDirector().viewSize()
        let maxGameLayerHeight = Double(size.height) - Constants.minimumHUDHeight*2
        var gameLayerHeight = Double(size.width)/Double(Constants.numberOfColumns)*Double(Constants.numberOfRows)
        var layerWidth = Double(size.width)
        
        if gameLayerHeight > maxGameLayerHeight {
            gameLayerHeight = maxGameLayerHeight
            layerWidth = Double(gameLayerHeight)/Double(Constants.numberOfRows)*Double(Constants.numberOfColumns)
        }
        
        gameLayer = GameLayer(size: CGSize(width: layerWidth, height: gameLayerHeight))
        gameLayer.position = CGPoint(x: size.width/2, y: size.height/2)
        gameLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let hudLayerHeight = max((Double(size.height) - gameLayerHeight)/2, Constants.minimumHUDHeight)
        let hudTopLayer = HUDTopLayer(size: CGSize(width: layerWidth, height: hudLayerHeight))
        hudTopLayer.position = CGPoint(x: size.width/2, y: size.height)
        hudTopLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        let hudBottomLayer = HUDBottomLayer(size: CGSize(width: layerWidth, height: hudLayerHeight))
        hudBottomLayer.position = CGPoint(x: size.width/2, y: 0)
        hudBottomLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        super.init()
        
        self.addChild(gameLayer, z: 100)
        self.addChild(hudTopLayer, z: 200)
        self.addChild(hudBottomLayer, z: 300)
    }
    
    func addMenuLayer(gameOver: Bool) {
        menuLayer = MenuLayer(gameOver: gameOver)
        self.addChild(menuLayer!, z: 400)
    }
    
    func resumeGame() {
        self.removeChild(menuLayer!)
    }
    
    func resetGame() {
        self.removeChild(menuLayer!)
        gameLayer.resetGame()
    }
}
