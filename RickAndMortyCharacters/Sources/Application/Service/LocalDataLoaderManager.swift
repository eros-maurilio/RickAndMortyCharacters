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
    
    func executeWithId<T: NSManagedObject>(_ id: String, completion: @escaping (Result<[T], CacheError>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: T.self))
        request.fetchLimit = 1
        request.predicate = .init(format: "characterId = %@", id)
        
        guard let fromDataBase = try? CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(request) as? [T],
        !fromDataBase.isEmpty else { return completion(.failure(.miss)) }
        
        completion(.success(fromDataBase))
    }
    
    @discardableResult
    func createAndInsertEntityFrom(character: CharacterDTO, endpoint: String) -> NSManagedObject? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        if let characterEntity = NSEntityDescription.insertNewObject(forEntityName: String(describing: CharacterData.self), into: context) as? CharacterData {
            
            characterEntity.characterId = String(character.id)
            characterEntity.name = character.name
            characterEntity.status = character.status
            characterEntity.specie = character.species
            characterEntity.type = character.type
            characterEntity.gender = character.gender
            characterEntity.originName = character.origin?.name
            characterEntity.locationName = character.location?.name
            characterEntity.image = character.image
            characterEntity.created = character.created
            characterEntity.endpoint = endpoint
            
            return characterEntity
        }
        return nil
    }
    
    func saveInCoreDataWith(object: [CharacterDTO], endpoint: String) {
        object.forEach { self.createAndInsertEntityFrom(character: $0, endpoint: endpoint) }
        
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            debugPrint(error)
        }
    }
}
