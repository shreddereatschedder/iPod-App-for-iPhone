import SwiftUI
import SwiftData

@main
struct iPodApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Song.self, Playlist.self])
        }
    }
}