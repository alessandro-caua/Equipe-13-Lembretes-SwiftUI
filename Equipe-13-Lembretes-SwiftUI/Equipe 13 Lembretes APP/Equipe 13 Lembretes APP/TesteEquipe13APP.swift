import SwiftUI

@main
struct TesteEquipe13App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab {
                    Text("1")
                } label: {
                    Label("Home1", systemImage: "house.fill")
                }
                
                Tab {
                    Text("2")
                } label: {
                    Label("Home2", systemImage: "house")
                }

            }
        }
    }
}
