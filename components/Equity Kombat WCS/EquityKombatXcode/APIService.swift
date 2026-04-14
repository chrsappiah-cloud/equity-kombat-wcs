// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class APIService {
    static let shared = APIService()
    private let baseURL = "https://your-backend-api.com/api/v1" // Replace with your backend URL
    private init() {}
    
    func fetchLeaderboard(completion: @escaping (Result<[[String: Any]], APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/leaderboard") else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    completion(.success(json))
                } else {
                    completion(.failure(.decodingFailed))
                }
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
    
    func submitScore(player: String, score: Int, completion: @escaping (Result<Bool, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/submit-score") else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["player": player, "score": score]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            completion(.success(true))
        }
        task.resume()
    }
}
