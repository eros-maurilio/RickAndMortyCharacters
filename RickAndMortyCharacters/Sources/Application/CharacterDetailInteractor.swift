protocol CharacterDetailBusinessLogic {
    func getCharacterDetail(_ request: CharacterDetail.PresentCharacter.Request)
}

final class CharacterDetailInteractor: CharacterDetailBusinessLogic {
    let worker = CharacterDetailWorker()
    var presenter: CharacterDetailPresentationLogic?
    
    func getCharacterDetail(_ request: CharacterDetail.PresentCharacter.Request) {
        worker.execute(withID: Int(request.id) ?? 0) { [weak self] character in
            guard let self else { return }
            self.presenter?.presentCharacterDetail(.init(character: .init(from: character)))
        }
    }
}
