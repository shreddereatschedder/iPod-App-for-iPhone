import Foundation
import YouTubeKit

class YouTubeService: ObservableObject {
    private let youTubeModel = YouTubeModel()

    func getAudioURL(from videoURL: String) async throws -> (streamURL: URL, title: String, artist: String, thumbnail: String, duration: Double) {
        guard let videoID = extractVideoID(from: videoURL) else {
            throw YouTubeError.invalidURL
        }

        let response: VideoInfosResponse = try await youTubeModel.sendRequest(
            responseType: VideoInfosResponse.self,
            videoId: videoID
        )

        guard let streamingInfo = response.streamingInfos else {
            throw YouTubeError.noStreamsFound
        }

        // Find best audio-only stream
        let audioStream = streamingInfo
            .filter { $0.type == .audio }
            .sorted { ($0.averageBitrate ?? 0) > ($1.averageBitrate ?? 0) }
            .first

        guard let stream = audioStream, let streamURL = stream.url else {
            throw YouTubeError.noAudioStream
        }

        let title = response.videoTitle ?? "Unknown Title"
        let artist = response.channel?.name ?? "Unknown Artist"
        let thumbnail = response.videoThumbnails?.last?.url?.absoluteString ?? ""
        let duration = Double(response.videoDuration ?? 0)

        return (streamURL, title, artist, thumbnail, duration)
    }

    private func extractVideoID(from urlString: String) -> String? {
        guard let url = URL(string: urlString) else { return nil }

        // Handle youtu.be/VIDEO_ID
        if url.host == "youtu.be" {
            return url.pathComponents.dropFirst().first
        }

        // Handle youtube.com/watch?v=VIDEO_ID
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItem = components.queryItems?.first(where: { $0.name == "v" }) {
            return queryItem.value
        }

        return nil
    }
}

enum YouTubeError: LocalizedError {
    case invalidURL
    case noStreamsFound
    case noAudioStream

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid YouTube URL"
        case .noStreamsFound: return "No streams found for this video"
        case .noAudioStream: return "No audio stream available"
        }
    }
}