# Equity Kombat iOS Game

## Requirements
- Xcode 15+
- iOS 17 SDK (or latest stable)
- Swift 5.9+
- SpriteKit, SwiftUI, AVFoundation (Apple frameworks)

## Setup
1. Open the EquityKombat.xcodeproj in Xcode.
2. Add your assets to `Assets.xcassets` (sprites, sounds: `bgm.mp3`, `punch.wav`, etc).
3. Build and run on Simulator or device.

## Dependencies
- No third-party dependencies required. Uses only Apple frameworks for world-class performance and compatibility.
- For backend/leaderboards, integrate with Firebase or CloudKit as needed.

## Firebase Backend Integration

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. Add an iOS app to your Firebase project. Download the `GoogleService-Info.plist` and add it to your Xcode project root.
3. In Xcode, go to File > Add Packages and add:
   - `https://github.com/firebase/firebase-ios-sdk.git`
   - Select `FirebaseCore` and `FirebaseDatabase` (and others as needed)
4. In your app, call `FirebaseApp.configure()` in your `AppDelegate` or main entry point.
5. Use `FirebaseManager.shared.saveScore(username:score:)` and `fetchTopScores(completion:)` for leaderboard features.

See `FirebaseIntegration.swift` for sample usage.

## Production Notes
- All code is modular and ready for scaling.
- Use asset catalogs for all images and sounds.
- Follow Apple HIG for UI/UX.
- Use App Store Connect for distribution.

## Extending
- Add more characters, moves, and effects by extending `FighterNode` and asset catalogs.
- Integrate Game Center for achievements/leaderboards.
- Use CloudKit or Firebase for multiplayer or persistent profiles.

---

For any issues, consult Apple Developer Documentation or open an issue in your project tracker.
