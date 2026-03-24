import SwiftUI

struct KombatTitle: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.custom("Impact", size: 48))
            .foregroundColor(.red)
            .shadow(color: .black, radius: 8, x: 0, y: 4)
            .padding(.top, 40)
    }
}

struct KombatButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Impact", size: 28))
                .foregroundColor(.yellow)
                .padding(.horizontal, 40)
                .padding(.vertical, 16)
                .background(LinearGradient(gradient: Gradient(colors: [.black, .red]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow, lineWidth: 4)
                )
                .shadow(color: .red.opacity(0.7), radius: 10, x: 0, y: 6)
        }
    }
}

struct KombatHealthBar: View {
    var health: CGFloat // 0...1
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 20)
                .foregroundColor(.gray.opacity(0.3))
                .cornerRadius(10)
            Rectangle()
                .frame(width: max(0, health) * 200, height: 20)
                .foregroundColor(health > 0.5 ? .green : (health > 0.2 ? .yellow : .red))
                .cornerRadius(10)
        }
        .frame(width: 200)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 2)
        )
    }
}
