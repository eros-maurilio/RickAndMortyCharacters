protocol CharacterDetailPresentationLogic {
    func presentCharacterDetail(_ response: CharacterDetail.PresentCharacter.Response)
}

class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    weak var viewControler: CharacterDetailViewDisplayLogic?
    
    func presentCharacterDetail(_ response: CharacterDetail.PresentCharacter.Response) {
        let viewModel = CharacterDetail.PresentCharacter.ViewModel(character: response.character)
        viewControler?.displayCharacter(viewModel: viewModel)
    }
}
