protocol CharactersListBusinessLogic {
    func getCharactersList(_ request: CharactersList.PresentCharacters.Request)
}

final class CharactersListInteractor: CharactersListBusinessLogic {
    var presenter: CharactersListPresentationLogic?
    var charactersListWorker = CharactersListWorker()
    
    // MARK: Do something
    
    func getCharactersList(_ request: CharactersList.PresentCharacters.Request) {
        charactersListWorker = CharactersListWorker()
        charactersListWorker.execute(withQuery: "1") { [weak self] characters in
            self?.presenter?.presentCharactersList(.init(characters: characters.map { .init(from: $0) }))
        }
    }
}
