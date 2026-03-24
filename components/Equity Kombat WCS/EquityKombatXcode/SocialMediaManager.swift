import Foundation
import UIKit

class SocialMediaManager {
    static let shared = SocialMediaManager()
    private init() {}
    
    func openTwitter(handle: String) {
        openURL("https://twitter.com/\(handle)")
    }
    func openFacebook(page: String) {
        openURL("https://facebook.com/\(page)")
    }
    func openInstagram(handle: String) {
        openURL("https://instagram.com/\(handle)")
    }
    func openYouTube(channel: String) {
        openURL("https://youtube.com/\(channel)")
    }
    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
    }
}
