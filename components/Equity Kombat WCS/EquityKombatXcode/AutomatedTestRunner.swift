// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import XCTest

class AutomatedTestRunner {
    static func runAllTests() {
        let testSuite = XCTestSuite.default
        testSuite.run()
        let run = testSuite.testRun as? XCTestSuiteRun
        print("Executed \(run?.executionCount ?? 0) tests, \(run?.failureCount ?? 0) failures")
    }
}
