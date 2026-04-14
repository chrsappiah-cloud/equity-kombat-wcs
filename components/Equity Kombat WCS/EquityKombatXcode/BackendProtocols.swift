import Foundation

protocol LeaderboardService {
    func fetchLeaderboard(completion: @escaping (Result<[[String: Any]], Error>) -> Void)
    func submitScore(player: String, score: Int, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol SecureStorageService {
    func storeToken(_ token: String)
    func retrieveToken() -> String?
}

extension APIService: LeaderboardService {
    func fetchLeaderboard(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        self.fetchLeaderboard { result in
            switch result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    func submitScore(player: String, score: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.submitScore(player: player, score: score) { result in
            switch result {
            case .success(let ok): completion(.success(ok))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}

extension SecurityManager: SecureStorageService {}
