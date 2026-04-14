// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import XCTest
@testable import EquityKombatXcode

class BackendIntegrationTests: XCTestCase {
    func testAuthLoginLogout() {
        let exp = expectation(description: "Login")
        AuthManager.shared.login(username: "test", password: "password") { success in
            XCTAssertTrue(success)
            XCTAssertTrue(AuthManager.shared.isAuthenticated)
            AuthManager.shared.logout()
            XCTAssertFalse(AuthManager.shared.isAuthenticated)
            exp.fulfill()
        }
        waitForExpectations(timeout: 2)
    }
    
    func testAPIServiceSubmitScore() {
        let exp = expectation(description: "Submit Score")
        APIService.shared.submitScore(player: "Tester", score: 99) { result in
            switch result {
            case .success(let ok): XCTAssertTrue(ok)
            case .failure: XCTFail("API call failed")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testAPIServiceFetchLeaderboard() {
        let exp = expectation(description: "Fetch Leaderboard")
        APIService.shared.fetchLeaderboard { result in
            switch result {
            case .success(let data): XCTAssertNotNil(data)
            case .failure: XCTFail("API call failed")
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
