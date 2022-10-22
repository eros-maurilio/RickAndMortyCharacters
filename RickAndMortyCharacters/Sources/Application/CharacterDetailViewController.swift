import UIKit

protocol CharacterDetailViewDisplayLogic: AnyObject {
    func dismissView()
    func displayCharacter(viewModel: CharacterDetail.PresentCharacter.ViewModel)
    func loadData(characterID: String)
}

class CharacterDetailViewController: UIViewController {
    var characterDetailView: CharacterDetailView = CharacterDetailView()
    var interactor: CharacterDetailBusinessLogic
    
    
    init(interactor: CharacterDetailBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = characterDetailView
        characterDetailView.viewController = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension CharacterDetailViewController: CharacterDetailViewDisplayLogic {
    func displayCharacter(viewModel: CharacterDetail.PresentCharacter.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.characterDetailView.configure(character: viewModel.character)            
        }
    }
    
    func dismissView() {
            navigationController?.popToRootViewController(animated: true)
            navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadData(characterID: String) {
        let request = CharacterDetail.PresentCharacter.Request(id: characterID)
        interactor.getCharacterDetail(request)
    }
}
