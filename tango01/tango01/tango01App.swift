import SwiftUI

@main
struct tango01App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            WordListView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
