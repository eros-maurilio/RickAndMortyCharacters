protocol CharactersListPresentationLogic {
    func presentCharactersList(_ response: CharactersList.PresentCharacters.Response)
}

class CharactersListPresenter: CharactersListPresentationLogic {
    weak var viewController: CharactersListDisplayLogic?
    
    // MARK: Do something
    
    func presentCharactersList(_ response: CharactersList.PresentCharacters.Response) {
        let viewModel = CharactersList.PresentCharacters.ViewModel(characters: response.characters)
        viewController?.displayCharactersList(viewModel: viewModel)
    }
}
