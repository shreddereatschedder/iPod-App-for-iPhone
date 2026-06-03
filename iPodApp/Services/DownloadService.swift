import Foundation

public class DownloadService {
    public init() {}

    public func downloadSong(from url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        // TODO: Implement download logic
        completion(.failure(NSError(domain: "DownloadService", code: -1, userInfo: nil)))
    }
}
