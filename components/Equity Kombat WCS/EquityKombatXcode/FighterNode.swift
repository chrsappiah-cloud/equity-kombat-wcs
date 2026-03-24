import SpriteKit

class FighterNode: SKSpriteNode {
    var health: CGFloat = 100.0
    var isPlayer: Bool = false
    var healthBar: SKShapeNode!
    var nameLabel: SKLabelNode!
    var isKO: Bool = false

    init(texture: SKTexture?, isPlayer: Bool, name: String) {
        super.init(texture: texture, color: .clear, size: texture?.size() ?? CGSize(width: 100, height: 100))
        self.isPlayer = isPlayer
        self.nameLabel = SKLabelNode(text: name)
        self.nameLabel.fontSize = 18
        self.nameLabel.fontColor = .white
        self.nameLabel.position = CGPoint(x: 0, y: self.size.height/2 + 20)
        addChild(nameLabel)
        setupHealthBar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupHealthBar() {
        healthBar = SKShapeNode(rectOf: CGSize(width: 80, height: 10), cornerRadius: 5)
        healthBar.fillColor = .green
        healthBar.strokeColor = .white
        healthBar.position = CGPoint(x: 0, y: self.size.height/2 + 10)
        addChild(healthBar)
    }

    func takeDamage(_ amount: CGFloat) {
        guard !isKO else { return }
        health -= amount
        if health < 0 { health = 0 }
        updateHealthBar()
        if health == 0 {
            isKO = true
            runKOAnimation()
        }
    }

    func updateHealthBar() 
        let percent = health / 100.0
        healthBar.xScale = percent
        if percent > 0.5 {
            healthBar.fillColor = .green
        } else if percent > 0.2 {
            healthBar.fillColor = .yellow
        } else {
            healthBar.fillColor = .red
        }
    }

    func runKOAnimation() {
        let fade = SKAction.fadeAlpha(to: 0.3, duration: 0.5)
        let rotate = SKAction.rotate(byAngle: .pi/2, duration: 0.5)
        let group = SKAction.group([fade, rotate])
        self.run(group)
    }
}
