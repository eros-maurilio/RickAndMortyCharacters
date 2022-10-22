import Foundation

struct CharacterDTO: Decodable {
    let name: String
    let image: String
    let id: Int
}

struct Info: Decodable {
    let pages: Int
}

struct CharactersListResponseDTO: Decodable {
    let results: [CharacterDTO]
    let info: Info
}

final class CharactersListWorker {
    typealias ListResult = Result<CharactersListResponseDTO, NSError>
    
    func execute(withQuery query: String, completion: @escaping (CharactersListResponseDTO) -> Void) {
        let dataLoaderManager = DataLoaderManager()
        
        dataLoaderManager.execute(.requestURLWith(.page, query: query)) { (result: ListResult) in
            switch result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                debugPrint(error)
                break // TODO completion error
            }
        }
    }
}
