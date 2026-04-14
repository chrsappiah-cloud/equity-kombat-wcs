import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = MenuScene(size: CGSize(width: 400, height: 600))
        scene.scaleMode = .aspectFill
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
