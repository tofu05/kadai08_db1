import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: false)
        let viewContext = controller.container.viewContext
        // プレビュー用のダミーデータを作成（必要に応じて追加）
        for _ in 0..<1 {
            let newItem = TangoWords(context: viewContext)
            newItem.word_id = UUID()
            newItem.name = ""
            newItem.content = ""
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "tango01") // ←プロジェクトの.xcdatamodeldファイル名に合わせる
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

// ★ viewContext プロパティを追加
extension PersistenceController {
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
}
