import SwiftUI

enum AppRoute: Hashable {
    case menu
    case fight(selectedCharacter: String)
    case leaderboard
    case feedback
    case social
}

class NavigationRouter: ObservableObject {
    @Published var path: [AppRoute] = [.menu]
    
    func goToMenu() { path = [.menu] }
    func goToFight(character: String) { path.append(.fight(selectedCharacter: character)) }
    func goToLeaderboard() { path.append(.leaderboard) }
    func goToFeedback() { path.append(.feedback) }
    func goToSocial() { path.append(.social) }
    func goBack() { if path.count > 1 { path.removeLast() } }
}

struct RootNavigationView: View {
    @StateObject var router = NavigationRouter()
    var body: some View {
        NavigationStack(path: $router.path) {
            routeView(for: router.path.last ?? .menu)
                .navigationDestination(for: AppRoute.self) { route in
                    routeView(for: route)
                }
        }
        .environmentObject(router)
    }
    @ViewBuilder
    func routeView(for route: AppRoute) -> some View {
        switch route {
        case .menu:
            AnimatedMenuView { character in
                router.goToFight(character: character)
            }
        case .fight(let selectedCharacter):
            SpriteView(scene: makeFightScene(selectedCharacter: selectedCharacter))
                .edgesIgnoringSafeArea(.all)
        case .leaderboard:
            LeaderboardOverlay()
        case .feedback:
            FeedbackView()
        case .social:
            SocialShareButtons()
        }
    }
    func makeFightScene(selectedCharacter: String) -> SKScene {
        let scene = FightScene(size: CGSize(width: 750, height: 1334))
        scene.selectedCharacter = selectedCharacter
        scene.scaleMode = .aspectFill
        return scene
    }
}
