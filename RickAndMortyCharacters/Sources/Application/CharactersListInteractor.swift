protocol CharactersListBusinessLogic {
    var shouldAnimate: Bool { get }
    func getCharactersList(_ request: CharactersList.PresentCharacters.Request)
}

final class CharactersListInteractor: CharactersListBusinessLogic {
    var presenter: CharactersListPresentationLogic?
    var charactersListWorker = CharactersListWorker()
    var charactersList = [CharacterDTO]()
    var maxPage = 0
    var canLoad = true
    var shouldAnimate: Bool { currentPage < maxPage }
    var currentPage = 0
    
    // MARK: Do something
    
    func getCharactersList(_ request: CharactersList.PresentCharacters.Request) {
        guard canLoad else { return }
        if maxPage == currentPage { canLoad = false }
        canLoad = false
        
        charactersListWorker.execute(withQuery: getCurrentPage()) { [weak self] characters in
            
            guard let self = self else { return }
            
            self.charactersList += characters.results
            self.maxPage = characters.info.pages
            self.presenter?.presentCharactersList(.init(characters: self.charactersList.map { .init(from: $0) }))
            self.canLoad = true
        }
    }
    
    private func getCurrentPage() -> String {
        currentPage += 1
        debugPrint(currentPage)
        return String(currentPage)
    }
}
