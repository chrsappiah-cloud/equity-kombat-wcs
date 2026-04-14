// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SwiftUI

struct FeedbackView: View {
    @State private var user = ""
    @State private var message = ""
    @State private var submitted = false
    @State private var error = false
    var body: some View {
        VStack(spacing: 24) {
            Text("Send Feedback")
                .font(.title)
                .bold()
            TextField("Your Name", text: $user)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextEditor(text: $message)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
            Button("Submit") {
                FeedbackManager.shared.submitFeedback(user: user, message: message) { success in
                    DispatchQueue.main.async {
                        submitted = success
                        error = !success
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            if submitted {
                Text("Thank you for your feedback!").foregroundColor(.green)
            } else if error {
                Text("Failed to send feedback.").foregroundColor(.red)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(radius: 8))
        .padding()
    }
}
