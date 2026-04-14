// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import Foundation

class KombatAPI {
    static let shared = KombatAPI()
    private let baseURL = "https://your-kombat-backend.com/api/v1" // Replace with your backend URL
    private init() {}
    
    func fetchFighters(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/fighters") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.requestFailed))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    completion(.success(json))
                } else {
                    completion(.failure(APIError.decodingFailed))
                }
            } catch {
                completion(.failure(APIError.decodingFailed))
            }
        }
        task.resume()
    }
    
    func fetchMoves(for fighter: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/fighters/\(fighter)/moves") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.requestFailed))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String] {
                    completion(.success(json))
                } else {
                    completion(.failure(APIError.decodingFailed))
                }
            } catch {
                completion(.failure(APIError.decodingFailed))
            }
        }
        task.resume()
    }
    
    func submitFightResult(winner: String, loser: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/fight-result") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["winner": winner, "loser": loser]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                completion(.failure(APIError.requestFailed))
                return
            }
            completion(.success(true))
        }
        task.resume()
    }
}
