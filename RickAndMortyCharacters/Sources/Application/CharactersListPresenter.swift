protocol CharactersListPresentationLogic {
    func presentCharactersList(_ response: CharactersList.UseCase.Response)
}

class CharactersListPresenter: CharactersListPresentationLogic {
    weak var viewController: CharactersListDisplayLogic?
    
    // MARK: Do something
    
    func presentCharactersList(_ response: CharactersList.UseCase.Response) {
        let viewModel = CharactersList.UseCase.ViewModel(characters: response.characters)
        viewController?.displayCharactersList(viewModel: viewModel)
    }
}
