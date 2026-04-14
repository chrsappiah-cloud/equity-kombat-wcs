// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import XCTest
@testable import EquityKombat

class FighterNodeTests: XCTestCase {
    func testAttackReducesHealth() {
        let attacker = FighterNode(color: .blue, size: CGSize(width: 80, height: 120))
        let target = FighterNode(color: .red, size: CGSize(width: 80, height: 120))
        let initialHealth = target.health
        attacker.attack(target: target)
        XCTAssertLessThan(target.health, initialHealth, "Attack should reduce target's health")
    }
}

class FirebaseManagerTests: XCTestCase {
    func testSaveScore() {
        // This is a stub. In production, use a test Firebase project or mock DatabaseReference.
        let manager = FirebaseManager.shared
        manager.saveScore(username: "TestUser", score: 999)
        // No assert: just ensure no crash. For real tests, mock Firebase.
    }
}
