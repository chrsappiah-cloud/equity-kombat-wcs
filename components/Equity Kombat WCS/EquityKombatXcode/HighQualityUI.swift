// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SwiftUI

struct HighQualityButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
}

struct HighQualityLabel: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 32, weight: .heavy, design: .rounded))
            .foregroundColor(.yellow)
            .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2)
    }
}

struct HighQualityBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.black, .blue, .purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}
