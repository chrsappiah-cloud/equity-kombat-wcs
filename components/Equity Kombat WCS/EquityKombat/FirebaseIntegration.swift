import Foundation
import FirebaseCore
import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    var ref: DatabaseReference!

    private init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        ref = Database.database().reference()
    }

    func saveScore(username: String, score: Int) {
        let scoreData = ["username": username, "score": score]
        ref.child("scores").childByAutoId().setValue(scoreData)
    }

    func fetchTopScores(completion: @escaping ([[String: Any]]) -> Void) {
        ref.child("scores").queryOrdered(byChild: "score").queryLimited(toLast: 10).observeSingleEvent(of: .value) { snapshot in
            var results: [[String: Any]] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot, let dict = snap.value as? [String: Any] {
                    results.append(dict)
                }
            }
            completion(results.reversed())
        }
    }
}
