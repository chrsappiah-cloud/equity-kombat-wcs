// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SpriteKit
import AVFoundation

class FightScene: SKScene {
    var player: FighterNode!
    var enemy: FighterNode!
    var selectedCharacter: String = "Equity Hero"
    var backgroundMusic: AVAudioPlayer?
    var gameOverLabel: SKLabelNode!
    var pauseOverlay: SKShapeNode!
    var isPausedOverlay = false
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupFighters()
        setupPauseOverlay()
        playBackgroundMusic()
    }
    
    func setupFighters() {
        let playerTexture = SKTexture(imageNamed: selectedCharacter)
        player = FighterNode(texture: playerTexture, isPlayer: true, name: selectedCharacter)
        player.position = CGPoint(x: size.width * 0.25, y: size.height/2)
        addChild(player)
        
        let enemyTexture = SKTexture(imageNamed: "Market Mage")
        enemy = FighterNode(texture: enemyTexture, isPlayer: false, name: "Market Mage")
        enemy.position = CGPoint(x: size.width * 0.75, y: size.height/2)
        addChild(enemy)
    }
    
    func setupPauseOverlay() {
        pauseOverlay = SKShapeNode(rectOf: CGSize(width: size.width * 0.8, height: size.height * 0.5), cornerRadius: 20)
        pauseOverlay.fillColor = .gray
        pauseOverlay.alpha = 0.8
        pauseOverlay.position = CGPoint(x: size.width/2, y: size.height/2)
        pauseOverlay.zPosition = 100
        pauseOverlay.isHidden = true
        addChild(pauseOverlay)
        let pauseLabel = SKLabelNode(text: "Paused")
        pauseLabel.fontSize = 44
        pauseLabel.position = CGPoint(x: 0, y: 0)
        pauseOverlay.addChild(pauseLabel)
    }
    
    func playBackgroundMusic() {
        if let musicURL = Bundle.main.url(forResource: "fight_theme", withExtension: "mp3") {
            backgroundMusic = try? AVAudioPlayer(contentsOf: musicURL)
            backgroundMusic?.numberOfLoops = -1
            backgroundMusic?.play()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isPausedOverlay, let touch = touches.first else { return }
        let location = touch.location(in: self)
        if player.contains(location) {
            enemy.takeDamage(CGFloat.random(in: 10...20))
            run(SKAction.playSoundFileNamed("punch.wav", waitForCompletion: false))
            if enemy.isKO { showGameOver(winner: true) }
        } else if enemy.contains(location) {
            player.takeDamage(CGFloat.random(in: 10...20))
            run(SKAction.playSoundFileNamed("kick.wav", waitForCompletion: false))
            if player.isKO { showGameOver(winner: false) }
        }
    }
    
    func showGameOver(winner: Bool) {
        // Advanced animation triggers
        if winner {
            AnimationManager.playVictoryAnimation(on: player)
            AnimationManager.playDefeatAnimation(on: enemy)
        } else {
            AnimationManager.playVictoryAnimation(on: enemy)
            AnimationManager.playDefeatAnimation(on: player)
        }
        // Animated overlay
        let overlay = SKShapeNode(rectOf: CGSize(width: size.width * 0.7, height: 180), cornerRadius: 32)
        overlay.fillColor = winner ? .green : .red
        overlay.alpha = 0.85
        overlay.position = CGPoint(x: size.width/2, y: size.height/2)
        overlay.zPosition = 250
        addChild(overlay)
        let label = SKLabelNode(text: winner ? "K.O.! YOU WIN" : "K.O.! YOU LOSE")
        label.fontName = "Impact"
        label.fontSize = 48
        label.fontColor = .yellow
        label.position = CGPoint(x: 0, y: 30)
        overlay.addChild(label)
        let restart = SKLabelNode(text: "Restart")
        restart.fontSize = 32
        restart.fontColor = .white
        restart.position = CGPoint(x: 0, y: -50)
        restart.name = "restart"
        overlay.addChild(restart)
        overlay.setScale(0.7)
        overlay.run(SKAction.scale(to: 1.0, duration: 0.3).timingMode(.easeOut))
        isUserInteractionEnabled = false
        run(SKAction.wait(forDuration: 2.0)) { [weak self] in
            self?.isUserInteractionEnabled = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let nodes = self.nodes(at: location)
        for node in nodes {
            if node.name == "restart" {
                let newScene = MenuScene(size: size)
                view?.presentScene(newScene, transition: SKTransition.crossFade(withDuration: 0.5))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard !isPausedOverlay, !player.isKO, !enemy.isKO else { return }
        // Simple AI: enemy attacks randomly
        if CGFloat.random(in: 0...1) < 0.01 {
            player.takeDamage(CGFloat.random(in: 5...15))
            run(SKAction.playSoundFileNamed("kick.wav", waitForCompletion: false))
            if player.isKO { showGameOver(winner: false) }
        }
    }
    
    func pauseGame() {
        isPausedOverlay = true
        pauseOverlay.isHidden = false
        self.isPaused = true
    }
    
    func resumeGame() {
        isPausedOverlay = false
        pauseOverlay.isHidden = true
        self.isPaused = false
    }
}
