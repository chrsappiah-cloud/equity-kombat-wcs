// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SpriteKit

class ParticleManager {
    static func addVictoryParticles(to scene: SKScene, at position: CGPoint) {
        if let emitter = SKEmitterNode(fileNamed: "VictoryParticle.sks") {
            emitter.position = position
            emitter.zPosition = 300
            scene.addChild(emitter)
        }
    }
    static func addKOExplosion(to scene: SKScene, at position: CGPoint) {
        if let emitter = SKEmitterNode(fileNamed: "KOExplosion.sks") {
            emitter.position = position
            emitter.zPosition = 300
            scene.addChild(emitter)
        }
    }
}
