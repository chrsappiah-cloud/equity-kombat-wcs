// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import XCTest

class EquityKombatUITests: XCTestCase {
    func testMenuCharacterSelection() {
        let app = XCUIApplication()
        app.launch()
        let startButton = app.staticTexts["Start Fight"]
        XCTAssertTrue(startButton.exists)
        app.staticTexts[">"].tap()
        app.staticTexts["<"].tap()
        startButton.tap()
    }
    
    func testFightAndGameOver() {
        let app = XCUIApplication()
        app.launch()
        app.staticTexts["Start Fight"].tap()
        // Simulate taps on player/enemy for attack
        let window = app.windows.element(boundBy: 0)
        window.tap()
        // Game over label should appear after enough taps
        // (In real test, use coordinate taps or accessibility identifiers)
    }
}
