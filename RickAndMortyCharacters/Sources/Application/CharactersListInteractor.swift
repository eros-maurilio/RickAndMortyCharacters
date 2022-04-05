protocol CharactersListBusinessLogic {
    func getCharactersList(_ request: CharactersList.UseCase.Request)
}

final class CharactersListInteractor: CharactersListBusinessLogic {
    var presenter: CharactersListPresentationLogic?
    var charactersListWorker = CharactersListWorker()
    
    // MARK: Do something
    
    func getCharactersList(_ request: CharactersList.UseCase.Request) {
        charactersListWorker = CharactersListWorker()
        
        let response = CharactersList.UseCase.Response(characters: charactersListWorker.execute(withQuery: "1"))
        
        presenter?.presentCharactersList(response)
    }
}
