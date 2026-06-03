import Foundation

public struct Playlist: Identifiable, Codable {
    public let id: UUID
    public var name: String
    public var songs: [Song]

    public init(id: UUID = UUID(), name: String, songs: [Song] = []) {
        self.id = id
        self.name = name
        self.songs = songs
    }
}
