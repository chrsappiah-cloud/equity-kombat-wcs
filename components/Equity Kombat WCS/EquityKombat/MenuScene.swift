// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.

// Example: Loading a texture from a Sprite Atlas
// let atlas = SKTextureAtlas(named: "fighters")
// let fighterTexture = atlas.textureNamed("fighter1")
// let fighterNode = SKSpriteNode(texture: fighterTexture)
// fighterNode.position = CGPoint(x: 100, y: 100)
// addChild(fighterNode)

class MenuScene: SKScene {
    let characters = [
        (name: "Advocate", color: UIColor.purple),
        (name: "Defender", color: UIColor.blue),
        (name: "Challenger", color: UIColor.red)
    ]
    var selectedIndex = 0
    var characterNode: SKSpriteNode!
    var nameLabel: SKLabelNode!
    var playLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black

        // PS-style gradient background
        let gradient = SKSpriteNode(color: .clear, size: size)
        gradient.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(gradient)

        // Character node
            let char = characters[selectedIndex]
            let texture = atlas.textureNamed(char.textureName)
            characterNode = SKSpriteNode(texture: texture, color: .clear, size: CGSize(width: 100, height: 150))
        characterNode.position = CGPoint(x: frame.midX, y: frame.midY)
        characterNode.name = "Character"
        addChild(characterNode)

        // Name label
        nameLabel = SKLabelNode(text: char.name)
        nameLabel.fontSize = 32
        nameLabel.fontColor = .white
        nameLabel.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(nameLabel)

        // Left/right arrows
        let leftArrow = SKLabelNode(text: "<")
        leftArrow.fontSize = 50
        leftArrow.fontColor = .white
        leftArrow.position = CGPoint(x: frame.midX - 120, y: frame.midY)
        leftArrow.name = "LeftArrow"
        addChild(leftArrow)

        let rightArrow = SKLabelNode(text: ">")
        rightArrow.fontSize = 50
        rightArrow.fontColor = .white
        rightArrow.position = CGPoint(x: frame.midX + 120, y: frame.midY)
        rightArrow.name = "RightArrow"
        addChild(rightArrow)

        // Play label
        playLabel = SKLabelNode(text: "Play")
        playLabel.fontSize = 40
        playLabel.fontColor = .white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        playLabel.name = "PlayLabel"
        addChild(playLabel)
    }

    func updateCharacterDisplay() {
        let char = characters[selectedIndex]
            let texture = atlas.textureNamed(char.textureName)
            characterNode.texture = texture
        nameLabel.text = char.name
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let node = atPoint(location)
            if node.name == "LeftArrow" {
                selectedIndex = (selectedIndex - 1 + characters.count) % characters.count
                updateCharacterDisplay()
            } else if node.name == "RightArrow" {
                selectedIndex = (selectedIndex + 1) % characters.count
                updateCharacterDisplay()
            } else if node.name == "PlayLabel" || node.name == "Character" {
                let fightScene = FightScene(size: size)
                fightScene.selectedCharacter = characters[selectedIndex]
                fightScene.scaleMode = .aspectFill
                view?.presentScene(fightScene, transition: .fade(withDuration: 0.5))
            }
        }
    }
}
