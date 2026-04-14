// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import Foundation

class EnhancedEndpoints {
    static let shared = EnhancedEndpoints()
    private let baseURL = "https://your-kombat-backend.com/api/v1"
    private init() {}
    
    func fetchPlayerStats(player: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/players/\(player)/stats") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(APIError.requestFailed))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
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
    
    func fetchAchievements(player: String, completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/players/\(player)/achievements") else {
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
}
