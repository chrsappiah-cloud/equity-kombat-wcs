import SwiftUI

struct LeaderboardOverlay: View {
    @State private var scores: [[String: Any]] = []
    @State private var isLoading = true
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .foregroundColor(.yellow)
                .padding(.top, 20)
            if isLoading {
                ProgressView()
            } else {
                List(scores, id: \ .self) { entry in
                    HStack {
                        Text(entry["player"] as? String ?? "-")
                        Spacer()
                        Text("\(entry["score"] as? Int ?? 0)")
                    }
                }
            }
        }
        .frame(width: 320, height: 400)
        .background(BlurView(style: .systemMaterialDark))
        .cornerRadius(24)
        .shadow(radius: 16)
        .onAppear(perform: loadScores)
    }
    
    func loadScores() {
        FirebaseManager.shared.fetchTopScores { results in
            DispatchQueue.main.async {
                self.scores = results
                self.isLoading = false
            }
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
