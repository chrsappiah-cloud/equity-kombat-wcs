// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SwiftUI

struct AnimatedMenuView: View {
    @State private var animate = false
    let characterNames = ["Equity Hero", "Finance Ninja", "Market Mage"]
    @State private var selectedIndex = 0
    var onStart: (String) -> Void
    var body: some View {
        ZStack {
            HighQualityBackground()
            VStack(spacing: 40) {
                KombatTitle(text: "EQUITY KOMBAT")
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: animate)
                HStack(spacing: 40) {
                    KombatButton(title: "<") {
                        selectedIndex = (selectedIndex - 1 + characterNames.count) % characterNames.count
                    }
                    HighQualityLabel(text: characterNames[selectedIndex])
                        .rotationEffect(.degrees(animate ? 5 : -5))
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: animate)
                    KombatButton(title: ">") {
                        selectedIndex = (selectedIndex + 1) % characterNames.count
                    }
                }
                KombatButton(title: "Start Fight") {
                    onStart(characterNames[selectedIndex])
                }
                .offset(y: animate ? -10 : 0)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: animate)
            }
        }
        .onAppear { animate = true }
    }
}
