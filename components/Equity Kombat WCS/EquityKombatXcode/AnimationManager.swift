// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SpriteKit

class AnimationManager {
    static func playVictoryAnimation(on node: SKNode) {
        let scaleUp = SKAction.scale(to: 1.3, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.2)
        let colorize = SKAction.colorize(with: .yellow, colorBlendFactor: 0.7, duration: 0.2)
        let sequence = SKAction.sequence([scaleUp, colorize, scaleDown])
        node.run(sequence)
    }
    
    static func playDefeatAnimation(on node: SKNode) {
        let fade = SKAction.fadeAlpha(to: 0.2, duration: 0.5)
        let rotate = SKAction.rotate(byAngle: .pi/2, duration: 0.5)
        let group = SKAction.group([fade, rotate])
        node.run(group)
    }
    
    static func playSpecialMove(on node: SKNode) {
        let pulse = SKAction.sequence([
            SKAction.scale(to: 1.2, duration: 0.1),
            SKAction.scale(to: 1.0, duration: 0.1)
        ])
        let repeatPulse = SKAction.repeat(pulse, count: 3)
        node.run(repeatPulse)
    }
}
