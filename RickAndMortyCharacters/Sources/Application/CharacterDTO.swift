struct CharacterDTO: Decodable {
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
    let endpoint: String?
}

struct InfoDTO: Decodable {
    let pages: Int
}

struct CharactersListResponseDTO: Decodable {
    let results: [CharacterDTO]
    let info: InfoDTO
}
