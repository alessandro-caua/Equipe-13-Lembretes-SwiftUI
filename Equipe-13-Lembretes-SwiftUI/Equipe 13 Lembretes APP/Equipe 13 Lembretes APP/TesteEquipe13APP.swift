import SwiftUI

@main
struct TesteEquipe13App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab {
                    DiaCalendarioEmLinha(data: .now, isSelected: true)
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
