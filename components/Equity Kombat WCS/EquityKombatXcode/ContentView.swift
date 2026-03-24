
// Import overlays and managers
import LeaderboardOverlay
import MultiplayerManager

struct ContentView: View {
    @State private var showFight = false
    @State private var selectedCharacter = "Equity Hero"
    @State private var showLeaderboard = false
    @State private var multiplayerConnected = false

    var body: some View {
        ZStack {
            if showFight {
                SpriteView(scene: makeFightScene())
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { showLeaderboard.toggle() }) {
                            Image(systemName: "list.number")
                                .font(.system(size: 28))
                                .padding()
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                        }
                    }
                    Spacer()
                }
                if showLeaderboard {
                    LeaderboardOverlay()
                        .transition(.move(edge: .top))
                        .zIndex(100)
                }
            } else {
                EnhancedMenuView { character in
                    selectedCharacter = character
                    MultiplayerManager.shared.connectToMatch { connected in
                        multiplayerConnected = connected
                        showFight = true
                    }
                }
            }
        }
    }
    func makeFightScene() -> SKScene {
        let scene = FightScene(size: CGSize(width: 750, height: 1334))
        scene.selectedCharacter = selectedCharacter
        scene.scaleMode = .aspectFill
        return scene
    }
}
