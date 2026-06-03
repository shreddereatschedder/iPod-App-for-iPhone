import Foundation

class DownloadService: ObservableObject {
    @Published var isDownloading = false
    @Published var progress: Double = 0

    func downloadAudio(from streamURL: URL, fileName: String) async throws -> URL {
        let documentsURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsURL.appendingPathComponent(fileName)

        // Skip if already exists
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            return destinationURL
        }

        await MainActor.run { isDownloading = true }

        let (tempURL, _) = try await URLSession.shared.download(from: streamURL)

        try FileManager.default.moveItem(at: tempURL, to: destinationURL)

        await MainActor.run {
            isDownloading = false
            progress = 0
        }

        return destinationURL
    }

    func deleteSong(fileName: String) throws {
        let documentsURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }
    }
}