import Foundation

class FeedbackManager {
    static let shared = FeedbackManager()
    private let feedbackURL = "https://your-backend-api.com/api/v1/feedback" // Replace with your endpoint
    private init() {}
    
    func submitFeedback(user: String, message: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: feedbackURL) else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["user": user, "message": message]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
}
