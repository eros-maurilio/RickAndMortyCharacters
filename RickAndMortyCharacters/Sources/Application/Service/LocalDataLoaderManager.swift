import Foundation
import CoreData

enum CacheError: Error {
    case miss
    case url
}

final class LocalDataLoaderManager {
    
    private var cache: NSCache<NSString, AnyObject> = .init()
    
    func execute<T: NSManagedObject>(_ endPoint: EndPoint, completion: @escaping (Result<[T], CacheError>) -> Void) {
        guard let cacheKey = endPoint.url?.absoluteString else { return completion(.failure(.url))}
        
        if let hit = cache.value(forKey: cacheKey),
           let data = hit as? [T] {
            return completion(.success(data))
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        request.predicate = .init(format: "endpoint = %@", cacheKey)
        
        guard let fromDataBase = try? CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(request) as? [T],
        !fromDataBase.isEmpty else { return completion(.failure(.miss)) }
        
        cache.setObject(fromDataBase as NSArray, forKey: cacheKey as NSString)
        completion(.success(fromDataBase))
    }
    
    @discardableResult
    func createAndInsertEntityFrom(character: CharacterDTO) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let characterEntity = NSEntityDescription.insertNewObject(forEntityName: String(describing: CharacterData.self), into: context) as? CharacterData {
            
            characterEntity.characterId = String(character.id)
            characterEntity.name = character.name
            characterEntity.status = character.status
            characterEntity.type = character.type
            characterEntity.gender = character.gender
            characterEntity.origin?.name = character.origin?.name
            characterEntity.location?.name = character.location?.name
            characterEntity.image = character.image
            characterEntity.created = character.created
            characterEntity.endpoint = character.endpoint
            
            return characterEntity
        }
        return nil
    }
    
    func saveInCoreDataWith(object: [CharacterDTO]) {
        object.forEach { self.createAndInsertEntityFrom(character: $0) }
        
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            debugPrint(error)
        }
    }
}
