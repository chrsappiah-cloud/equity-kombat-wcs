import Foundation
import Firebase

class FirebaseManager {
    static let shared = FirebaseManager()
    private init() {
        FirebaseApp.configure()
    }
    
    func saveScore(player: String, score: Int, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference()
        let scoreData = ["player": player, "score": score, "timestamp": Date().timeIntervalSince1970] as [String : Any]
        ref.child("scores").childByAutoId().setValue(scoreData) { error, _ in
            completion(error == nil)
        }
    }
    
    func fetchTopScores(limit: UInt = 10, completion: @escaping ([[String: Any]]) -> Void) {
        let ref = Database.database().reference()
        ref.child("scores").queryOrdered(byChild: "score").queryLimited(toLast: limit).observeSingleEvent(of: .value) { snapshot in
            var results: [[String: Any]] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot, let dict = snap.value as? [String: Any] {
                    results.append(dict)
                }
            }
            results.sort { ($0["score"] as? Int ?? 0) > ($1["score"] as? Int ?? 0) }
            completion(results)
        }
    }
}
