// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import Foundation

class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    var isAuthenticated: Bool {
        return SecurityManager.shared.retrieveToken() != nil
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // Example: Replace with real API call
        let sanitizedUsername = SecurityManager.shared.sanitize(input: username)
        let sanitizedPassword = SecurityManager.shared.sanitize(input: password)
        // Simulate API call
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            if sanitizedUsername == "test" && sanitizedPassword == "password" {
                SecurityManager.shared.storeToken("dummyToken123")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func logout() {
        SecurityManager.shared.storeToken("")
    }
}
