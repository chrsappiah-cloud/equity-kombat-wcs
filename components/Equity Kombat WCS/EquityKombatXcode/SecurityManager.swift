// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import Foundation

class SecurityManager {
    static let shared = SecurityManager()
    private init() {}
    
    // Example: Validate API responses
    func validateResponse(_ data: Data?, response: URLResponse?, error: Error?) -> Bool {
        guard error == nil, let httpResponse = response as? HTTPURLResponse else { return false }
        return (200...299).contains(httpResponse.statusCode)
    }
    
    // Example: Sanitize user input
    func sanitize(input: String) -> String {
        // Remove unwanted characters, limit length, etc.
        let allowed = CharacterSet.alphanumerics.union(.whitespaces)
        return String(input.unicodeScalars.filter { allowed.contains($0) }).prefix(32).description
    }
    
    // Example: Securely store sensitive data
    func storeToken(_ token: String) {
        // Use Keychain or secure storage in production
        UserDefaults.standard.set(token, forKey: "authToken")
    }
    
    func retrieveToken() -> String? {
        return UserDefaults.standard.string(forKey: "authToken")
    }
}
