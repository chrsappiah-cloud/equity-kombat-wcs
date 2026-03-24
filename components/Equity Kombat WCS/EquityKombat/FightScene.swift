    var pauseButton: SKLabelNode!
    var isPausedManually = false
    // Pause button
    pauseButton = SKLabelNode(text: "Pause")
    pauseButton.fontSize = 28
    pauseButton.fontColor = .white
    pauseButton.position = CGPoint(x: frame.width - 60, y: frame.height - 40)
    pauseButton.name = "PauseButton"
    addChild(pauseButton)
import AVFoundation
    var backgroundMusicPlayer: AVAudioPlayer?
    // Play background music
    playBackgroundMusic()
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "bgm", withExtension: "mp3") else { return }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = 0.5
            backgroundMusicPlayer?.play()
        } catch {
            print("Could not play background music: \(error)")
        }
    }
    override func willMove(from view: SKView) {
        enemyAITimer?.invalidate()
        backgroundMusicPlayer?.stop()
    }
import SpriteKit
import AVFoundation
// Example: Playing a sound effect with SpriteKit
// let punchSound = SKAction.playSoundFileNamed("punch.wav", waitForCompletion: false)
// fighterNode.run(punchSound)

// Example: Playing background music with AVFoundation
// var musicPlayer: AVAudioPlayer?
// func playBackgroundMusic() {
//     guard let url = Bundle.main.url(forResource: "bgm", withExtension: "mp3") else { return }
//     do {
//         musicPlayer = try AVAudioPlayer(contentsOf: url)
//         musicPlayer?.numberOfLoops = -1
//         musicPlayer?.play()
//     } catch {
//         print("Error playing music: \(error)")
//     }
// }
// Example: Saving and fetching scores with Firebase
// FirebaseManager.shared.saveScore(username: "Player1", score: 1234)
// FirebaseManager.shared.fetchTopScores { scores in
//     for score in scores {
//         if let username = score["username"] as? String, let value = score["score"] as? Int {
//             print("User: \(username), Score: \(value)")
//         }
//     }
// }

class FightScene: SKScene, SKPhysicsContactDelegate {
    var player: FighterNode!
    var enemy: FighterNode!
    var healthBarPlayer: SKSpriteNode!
    var healthBarEnemy: SKSpriteNode!
    var selectedCharacter: (name: String, color: UIColor)?
    var enemyAITimer: Timer?
    var gameOverLabel: SKLabelNode?
    var isGameOver = false

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.2, alpha: 1.0)

        // Arena floor
        let floor = SKSpriteNode(color: .gray, size: CGSize(width: frame.width, height: 50))
        floor.position = CGPoint(x: frame.midX, y: 50)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.isDynamic = false
        addChild(floor)

        // Player
        let playerColor = selectedCharacter?.color ?? .blue
        player = FighterNode(color: playerColor, size: CGSize(width: 80, height: 120))
        player.position = CGPoint(x: frame.midX - 150, y: 100)
        player.health = 100
        addChild(player)

        // Enemy (random other character)
        let enemyColor: UIColor = {
            let allColors: [UIColor] = [.purple, .blue, .red]
            let filtered = allColors.filter { $0 != playerColor }
            return filtered.randomElement() ?? .red
        }()
        enemy = FighterNode(color: enemyColor, size: CGSize(width: 80, height: 120))
        enemy.position = CGPoint(x: frame.midX + 150, y: 100)
        enemy.health = 100
        enemy.isAI = true
        addChild(enemy)

        // HUD
        healthBarPlayer = SKSpriteNode(color: .green, size: CGSize(width: 200, height: 20))
        healthBarPlayer.position = CGPoint(x: frame.midX - 100, y: frame.height - 50)
        addChild(healthBarPlayer)

        healthBarEnemy = SKSpriteNode(color: .green, size: CGSize(width: 200, height: 20))
        healthBarEnemy.position = CGPoint(x: frame.midX + 100, y: frame.height - 50)
        addChild(healthBarEnemy)

        // Start enemy AI
        enemyAITimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.enemy.health > 0 && self.player.health > 0 {
                self.enemy.attack(target: self.player)
            }
        }
    }

    override func willMove(from view: SKView) {
        enemyAITimer?.invalidate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if isGameOver {
            if node.name == "RestartButton" {
                restartGame()
            }
            return
        }
        if node.name == "PauseButton" {
            isPausedManually.toggle()
            self.isPaused = isPausedManually
            pauseButton.text = isPausedManually ? "Resume" : "Pause"
            return
        }
        if !isPausedManually {
            player.attack(target: enemy)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Update health bars
        let playerHealthRatio = max(player.health, 0) / 100.0
        let enemyHealthRatio = max(enemy.health, 0) / 100.0
        healthBarPlayer.xScale = CGFloat(playerHealthRatio)
        healthBarEnemy.xScale = CGFloat(enemyHealthRatio)

        // Check for game over
        if !isGameOver {
            if player.health <= 0 {
                showGameOver(winner: "Enemy")
            } else if enemy.health <= 0 {
                showGameOver(winner: "Player")
            }
        }
    }

    func showGameOver(winner: String) {
        isGameOver = true
        enemyAITimer?.invalidate()
        // KO effect
        let koLabel = SKLabelNode(text: "KO!")
        koLabel.fontSize = 80
        koLabel.fontColor = .red
        koLabel.position = CGPoint(x: frame.midX, y: frame.midY + 60)
        addChild(koLabel)
        let fadeOut = SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
        ])
        koLabel.run(fadeOut)

        gameOverLabel = SKLabelNode(text: "Game Over! \(winner) Wins")
        gameOverLabel?.fontSize = 44
        gameOverLabel?.fontColor = .yellow
        gameOverLabel?.position = CGPoint(x: frame.midX, y: frame.midY)
        if let label = gameOverLabel {
            label.alpha = 0
            addChild(label)
            let appear = SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.fadeIn(withDuration: 0.5)
            ])
            label.run(appear)
        }

        // Restart button
        let restartButton = SKLabelNode(text: "Restart")
        restartButton.fontSize = 36
        restartButton.fontColor = .white
        restartButton.position = CGPoint(x: frame.midX, y: frame.midY - 60)
        restartButton.name = "RestartButton"
        restartButton.alpha = 0
        addChild(restartButton)
        let appearRestart = SKAction.sequence([
            SKAction.wait(forDuration: 1.5),
            SKAction.fadeIn(withDuration: 0.5)
        ])
            let playerTextureName = selectedCharacter?.textureName ?? "advocate"
            let playerTexture = atlas.textureNamed(playerTextureName)
            player = FighterNode(texture: playerTexture, color: .clear, size: CGSize(width: 80, height: 120))

    func restartGame() {
        let newScene = FightScene(size: self.size)
        newScene.selectedCharacter = self.selectedCharacter
        newScene.scaleMode = self.scaleMode
            let allTextureNames = ["advocate", "defender", "challenger"]
            let enemyTextureName = allTextureNames.filter { $0 != playerTextureName }.randomElement() ?? "challenger"
            let enemyTexture = atlas.textureNamed(enemyTextureName)
            enemy = FighterNode(texture: enemyTexture, color: .clear, size: CGSize(width: 80, height: 120))
