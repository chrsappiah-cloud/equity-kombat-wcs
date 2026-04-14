// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SpriteKit

class MenuScene: SKScene {
    var characterNames = ["Equity Hero", "Finance Ninja", "Market Mage"]
    var selectedIndex = 0
    var characterLabel: SKLabelNode!
    var startButton: SKLabelNode!

    override func didMove(to view: SKView) {
        backgroundColor = .darkGray
        characterLabel = SKLabelNode(text: characterNames[selectedIndex])
        characterLabel.fontSize = 40
        characterLabel.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(characterLabel)
        
        let left = SKLabelNode(text: "<")
        left.fontSize = 40
        left.position = CGPoint(x: size.width/2 - 100, y: size.height/2)
        left.name = "left"
        addChild(left)
        
        let right = SKLabelNode(text: ">")
        right.fontSize = 40
        right.position = CGPoint(x: size.width/2 + 100, y: size.height/2)
        right.name = "right"
        addChild(right)
        
        startButton = SKLabelNode(text: "Start Fight")
        startButton.fontSize = 32
        startButton.position = CGPoint(x: size.width/2, y: size.height/2 - 100)
        startButton.name = "start"
        addChild(startButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        for node in nodes {
            if node.name == "left" {
                selectedIndex = (selectedIndex - 1 + characterNames.count) % characterNames.count
                characterLabel.text = characterNames[selectedIndex]
            } else if node.name == "right" {
                selectedIndex = (selectedIndex + 1) % characterNames.count
                characterLabel.text = characterNames[selectedIndex]
            } else if node.name == "start" {
                let fightScene = FightScene(size: size)
                fightScene.selectedCharacter = characterNames[selectedIndex]
                view?.presentScene(fightScene, transition: SKTransition.flipHorizontal(withDuration: 0.5))
            }
        }
    }
}
