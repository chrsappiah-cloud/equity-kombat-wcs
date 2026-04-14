// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
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
