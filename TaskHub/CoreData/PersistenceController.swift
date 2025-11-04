
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // datos de ejemplo
        for i in 1...3 {
            let item = TaskHubItem(context: viewContext)
            item.name = "Tarea \(i)"
            item.desc = "Descripción \(i)"
            item.date = Date()
        }
        do { try viewContext.save() } catch {
            fatalError("Error guardando preview store: \(error)")
        }
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        let modelName = "TaskHub"
        container = NSPersistentContainer(name: modelName)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Mensaje claro para debugging
                fatalError("Error al cargar Core Data store: \(error), \(error.userInfo)")
            } else {
                print("✅ Core Data loaded: \(storeDescription.url?.absoluteString ?? "in-memory")")
            }
        }

        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
