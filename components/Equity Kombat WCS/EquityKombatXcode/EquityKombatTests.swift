// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import XCTest
@testable import EquityKombatXcode

class EquityKombatTests: XCTestCase {
    func testFighterTakesDamage() {
        let texture = SKTexture(imageNamed: "Equity Hero")
        let fighter = FighterNode(texture: texture, isPlayer: true, name: "Equity Hero")
        fighter.takeDamage(30)
        XCTAssertEqual(fighter.health, 70)
    }
    
    func testKOLogic() {
        let texture = SKTexture(imageNamed: "Finance Ninja")
        let fighter = FighterNode(texture: texture, isPlayer: false, name: "Finance Ninja")
        fighter.takeDamage(100)
        XCTAssertTrue(fighter.isKO)
    }
    
    func testFirebaseSaveScore() {
        let exp = expectation(description: "Save score")
        FirebaseManager.shared.saveScore(player: "TestPlayer", score: 123) { success in
            XCTAssertTrue(success)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
