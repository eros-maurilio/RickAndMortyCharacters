enum CharactersList {
    
    struct Character {
        let name: String
        let imageURL: String
    }
    
    enum PresentCharacters {
        
        struct Request { }
        
        struct Response {
            let characters: [Character]
        }
        
        struct ViewModel {
            let characters: [Character]
        }
        
    }
}

// MARK: - Adapter

extension CharactersList.Character {
    init(from dto: CharacterDTO) {
        self.init(name: dto.name, imageURL: dto.image)
    }
}
