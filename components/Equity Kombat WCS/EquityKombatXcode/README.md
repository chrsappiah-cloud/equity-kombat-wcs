# Equity Kombat Xcode Game

## Features
- SpriteKit + SwiftUI hybrid architecture
- Multiple playable characters with selection menu
- Advanced AI for enemy
- Health bars, KO/game over logic
- Attack/damage animations and sound effects
- Pause and game over overlays
- Firebase backend for leaderboard/score saving
- Asset, sound, and resource folders scaffolded

## Setup
1. Open this folder in Xcode.
2. Add your images to `Assets.xcassets` and sounds to `Sounds`.
3. Add your Firebase `GoogleService-Info.plist` to the root.
4. Use Swift Package Manager to add Firebase dependencies.
5. Build and run on Simulator or device.

## File Overview
- `AppDelegate.swift`, `SceneDelegate.swift`, `main.swift`: App lifecycle
- `ContentView.swift`: SwiftUI entry
- `MenuScene.swift`: Character selection
- `FightScene.swift`: Main game logic
- `FighterNode.swift`: Player/enemy node logic
- `FirebaseManager.swift`: Backend integration

## Production Notes
- All code is modular and ready for extension.
- UI and backend are decoupled for easy testing.
- Add more characters, effects, and features as needed.
