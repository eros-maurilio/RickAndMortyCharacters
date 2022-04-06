import Foundation

struct CharacterDTO: Decodable {
    let name: String
    let id: Int
}

struct CharactersListResponseDTO: Decodable {
    let results: [CharacterDTO]
}

final class CharactersListWorker {
    typealias ListResult = Result<CharactersListResponseDTO, NSError>
    
    func execute(withQuery query: String, completion: @escaping ([CharacterDTO]) -> Void) {
        let dataLoaderManager = DataLoaderManager()
        
        dataLoaderManager.execute(.requestURLWith(.page, query: query)) { [weak self] (result: ListResult) in
                    
            guard let self = self else { return }
            
            switch result {
            case let .success(data):
                completion(data.results)
            case let .failure(error):
                break // TODO completion error
            }
        }
    }
}
