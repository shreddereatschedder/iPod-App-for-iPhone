import Foundation
import SwiftData

@Model
class Playlist {
    var id: UUID
    var name: String
    var dateCreated: Date
    @Relationship var songs: [Song]

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.dateCreated = Date()
        self.songs = []
    }
}