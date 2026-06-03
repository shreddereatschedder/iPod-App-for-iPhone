import Foundation

class YouTubeService {
    init() {}

    func search(query: String, completion: @escaping ([Song]) -> Void) {
        completion([])
    }
}