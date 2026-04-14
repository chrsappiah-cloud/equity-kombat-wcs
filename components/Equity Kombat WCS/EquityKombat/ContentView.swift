// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
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
