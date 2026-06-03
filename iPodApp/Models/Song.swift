import Foundation

public struct Song: Identifiable, Codable {
    public let id: UUID
    public var title: String
    public var artist: String?
    public var duration: TimeInterval?
    public var url: URL?

    public init(id: UUID = UUID(), title: String, artist: String? = nil, duration: TimeInterval? = nil, url: URL? = nil) {
        self.id = id
        self.title = title
        self.artist = artist
        self.duration = duration
        self.url = url
    }
}
