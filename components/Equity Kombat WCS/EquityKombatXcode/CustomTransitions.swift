// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SwiftUI

extension AnyTransition {
    static var kombatFlip: AnyTransition {
        .modifier(
            active: FlipEffect(angle: 90),
            identity: FlipEffect(angle: 0)
        )
    }
}

struct FlipEffect: ViewModifier {
    let angle: Double
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(angle),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
    }
}
