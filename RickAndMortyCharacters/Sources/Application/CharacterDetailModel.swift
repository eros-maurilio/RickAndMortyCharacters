enum CharacterDetail {
    struct Character {
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
    
    enum PresentCharacter {
        struct Request {
            let id: String
        }
        
        struct Response {
            let character: Character
        }
        
        struct ViewModel {
            let character: Character
        }
    }
}

// MARK: - Adapter

extension CharacterDetail.Character {
    init(from dto: CharacterDTO) {
        self.init(id: dto.id,
                  name: dto.name,
                  status: dto.status,
                  species: dto.species,
                  type: dto.type,
                  gender: dto.gender,
                  origin: dto.origin,
                  location: dto.location,
                  image: dto.image,
                  created: dto.created)
    }
}
