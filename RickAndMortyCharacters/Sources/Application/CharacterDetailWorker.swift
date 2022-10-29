import Foundation

struct Origin: Decodable {
    let name: String
}

struct Location: Decodable {
    let name: String
}


final class CharacterDetailWorker {
    typealias CharacterDetailResult = Result<[CharacterData], CacheError>
    
    func execute(withID id: Int, completion: @escaping (CharacterDTO) -> Void) {
        let localLoaderManager = LocalDataLoaderManager()
        
        localLoaderManager.executeWithId(String(id)) { (result: CharacterDetailResult) in
            switch result {
            case let .success(data):
                guard let character = data.first else { return }
                let dto = CharacterDTO(id: Int(character.characterId ?? "0") ?? 0,
                                       name: character.name ?? "",
                                       status: character.status ?? "",
                                       species: character.specie ?? "",
                                       type: character.type ?? "",
                                       gender: character.gender ?? "",
                                       origin: Origin(name: character.originName ?? ""),
                                       location: Location(name: character.locationName ?? ""),
                                       image: character.image ?? "",
                                       created: character.created ?? "",
                                       endpoint: character.endpoint)
                completion(dto)
            case let .failure(error):
                debugPrint(error)
                break
            }
        }
    }
}

