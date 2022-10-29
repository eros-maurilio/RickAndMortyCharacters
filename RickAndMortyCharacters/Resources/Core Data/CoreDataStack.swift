import CoreData

final class CoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CharacterData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    static let sharedInstance = CoreDataStack()
    private override init() { }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationDocumentsDirectory() {
            if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
                print(url.absoluteString)
            }
        }
    
}
