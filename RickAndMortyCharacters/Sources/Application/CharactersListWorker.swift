import Foundation
import CoreData

final class CharactersListWorker {
    
    typealias ListResult = Result<CharactersListResponseDTO, NSError>
    typealias CoreDataResult = Result<[CharacterData], CacheError>
    
    func execute(withQuery query: String, completion: @escaping (CharactersListResponseDTO) -> Void) {
        let dataLoaderManager = NetworkDataLoaderManager()
        let localDataLoaderManager = LocalDataLoaderManager()
        let endpoint = EndPoint.requestURLWith(.page, query: query)
        guard let endpointString: String = endpoint.url?.absoluteString else { return }
        
        localDataLoaderManager.execute(endpoint) { (result: CoreDataResult) in
            switch result {
            case let .success(data):
                var characterList = [CharacterDTO]()
                
                data.forEach {
                    let character = CharacterDTO(id: Int($0.characterId ?? "0") ?? 0,
                                                 name: $0.name  ?? "",
                                                 status: $0.status ?? "",
                                                 species: $0.specie ?? "",
                                                 type: $0.type  ?? "",
                                                 gender: $0.gender ?? "",
                                                 origin: Origin(name: $0.originName ?? ""),
                                                 location: Location(name: $0.originName ?? ""),
                                                 image: $0.image ?? "",
                                                 created: $0.created ?? "",
                                                 endpoint: endpointString)
                    
                    characterList.append(character)
                }
                

                completion(CharactersListResponseDTO(results: characterList, info: InfoDTO(pages: 42)))
                
            case .failure(CacheError.miss):
                dataLoaderManager.execute(.requestURLWith(.page, query: query)) { (result: ListResult) in
                    
                    switch result {
                    case let .success(data):
                        localDataLoaderManager.saveInCoreDataWith(object: data.results, endpoint: endpointString)
                        completion(data)
                        
                    case let .failure(error):
                        debugPrint(error)
                    }
                }
            case .failure(.url):
                debugPrint("Bad Url")
            }
        }
    }
}
