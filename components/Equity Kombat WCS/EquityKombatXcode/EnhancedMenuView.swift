// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SwiftUI

struct EnhancedMenuView: View {
    @State private var selectedIndex = 0
    let characterNames = ["Equity Hero", "Finance Ninja", "Market Mage"]
    var onStart: (String) -> Void
    
    var body: some View {
        ZStack {
            HighQualityBackground()
            VStack(spacing: 40) {
                KombatTitle(text: "EQUITY KOMBAT")
                HStack(spacing: 40) {
                    KombatButton(title: "<") {
                        selectedIndex = (selectedIndex - 1 + characterNames.count) % characterNames.count
                    }
                    HighQualityLabel(text: characterNames[selectedIndex])
                    KombatButton(title: ">") {
                        selectedIndex = (selectedIndex + 1) % characterNames.count
                    }
                }
                KombatButton(title: "Start Fight") {
                    onStart(characterNames[selectedIndex])
                }
            }
        }
    }
}
