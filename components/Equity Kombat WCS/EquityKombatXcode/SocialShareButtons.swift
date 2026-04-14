// Copyright (c) 2026 World Class Scholars, led by Dr Christopher Appiah-Thompson. All rights reserved.
import SwiftUI

struct SocialShareButtons: View {
    var body: some View {
        HStack(spacing: 24) {
            Button(action: { SocialMediaManager.shared.openTwitter(handle: "YourGameHandle") }) {
                Image("twitter_icon").resizable().frame(width: 40, height: 40)
            }
            Button(action: { SocialMediaManager.shared.openFacebook(page: "YourGamePage") }) {
                Image("facebook_icon").resizable().frame(width: 40, height: 40)
            }
            Button(action: { SocialMediaManager.shared.openInstagram(handle: "YourGameHandle") }) {
                Image("instagram_icon").resizable().frame(width: 40, height: 40)
            }
            Button(action: { SocialMediaManager.shared.openYouTube(channel: "YourGameChannel") }) {
                Image("youtube_icon").resizable().frame(width: 40, height: 40)
            }
        }
    }
}
