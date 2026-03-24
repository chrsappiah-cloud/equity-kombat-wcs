import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .black
        let label = SKLabelNode(text: "Equity Kombat")
        label.fontSize = 44
        label.fontColor = .white
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
    }
}
