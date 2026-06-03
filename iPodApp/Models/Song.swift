import Foundation
import SwiftData

@Model
class Song {
    var id: UUID
    var title: String
    var artist: String
    var album: String
    var duration: Double
    var thumbnailURL: String
    var youtubeURL: String
    var isFavourite: Bool
    var dateAdded: Date
    var fileName: String

    init(
        title: String,
        artist: String,
        album: String = "Unknown Album",
        duration: Double = 0,
        thumbnailURL: String = "",
        youtubeURL: String = "",
        fileName: String
    ) {
        self.id = UUID()
        self.title = title
        self.artist = artist
        self.album = album
        self.duration = duration
        self.thumbnailURL = thumbnailURL
        self.youtubeURL = youtubeURL
        self.isFavourite = false
        self.dateAdded = Date()
        self.fileName = fileName
    }

    var fileURL: URL? {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(fileName)
    }
}