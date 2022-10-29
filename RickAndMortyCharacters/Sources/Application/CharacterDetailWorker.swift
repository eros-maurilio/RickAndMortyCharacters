import Foundation

struct CharacterDetailDTO: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String?
    let type: String?
    let gender: String?
    let origin: Origin?
    let location: Location?
    let image: String
    let created: String
}

struct Origin: Decodable {
    let name: String
}

struct Location: Decodable {
    let name: String
}

struct CharacterDetailResponseDTO: Decodable {
    let result: CharacterDetailDTO
}

final class CharacterDetailWorker {
    typealias CharacterDetailResult = Result<CharacterDetailDTO, NSError>
    
    func execute(withID id: Int, completion: @escaping (CharacterDetailDTO) -> Void) {
        let dataLoaderManager = NetworkDataLoaderManager()
        
        dataLoaderManager.execute(.requestCharacterURLWith(id: id)) { (result: CharacterDetailResult) in
            switch result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                debugPrint(error)
                break
            }
        }
    }
}

