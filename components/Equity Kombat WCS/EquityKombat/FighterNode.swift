import AVFoundation
    var punchSoundPlayer: AVAudioPlayer?
import SpriteKit

class FighterNode: SKSpriteNode {
    var health: CGFloat = 100
    var isAI: Bool = false

    init(color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        name = "Fighter"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = true
        physicsBody?.categoryBitMask = 1
        physicsBody?.contactTestBitMask = 1
        physicsBody?.collisionBitMask = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func attack(target: FighterNode) {
        playPunchSound()
            func playPunchSound() {
                guard let url = Bundle.main.url(forResource: "punch", withExtension: "wav") else { return }
                do {
                    punchSoundPlayer = try AVAudioPlayer(contentsOf: url)
                    punchSoundPlayer?.volume = 1.0
                    punchSoundPlayer?.play()
                } catch {
                    print("Could not play punch sound: \(error)")
                }
            }
        // Punch action with shake
        let punch = SKAction.sequence([
            SKAction.moveBy(x: 50, y: 0, duration: 0.15),
            SKAction.run {
                // Damage effect
                target.health -= 10
                let hitEffect = SKEmitterNode(fileNamed: "damage") ?? SKSpriteNode(color: .yellow, size: CGSize(width: 20, height: 20))
                hitEffect.position = target.position
                target.parent?.addChild(hitEffect)
                // Shake animation
                let shake = SKAction.sequence([
                    SKAction.moveBy(x: 10, y: 0, duration: 0.05),
                    SKAction.moveBy(x: -20, y: 0, duration: 0.05),
                    SKAction.moveBy(x: 10, y: 0, duration: 0.05)
                ])
                target.run(shake)
            },
            SKAction.moveBy(x: -50, y: 0, duration: 0.15)
        ])
        run(punch)
    }
}
