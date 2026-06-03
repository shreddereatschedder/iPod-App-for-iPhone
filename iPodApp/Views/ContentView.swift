import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Library")
                .tabItem {
                    Label("Library", systemImage: "music.note.list")
                }
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Text("Playlists")
                .tabItem {
                    Label("Playlists", systemImage: "music.note.list")
                }
        }
    }
}