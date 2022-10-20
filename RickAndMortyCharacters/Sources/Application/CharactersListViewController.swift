import UIKit

typealias Character = CharactersList.Character

protocol CharactersListDisplayLogic: AnyObject {
    func displayCharactersList(viewModel: CharactersList.PresentCharacters.ViewModel)
}

class CharactersListViewController: UIViewController {
    private let interactor: CharactersListBusinessLogic
    private let adapter: CharacterListAdapting
    private let router: CharactersListRouter
    
    private var characterList: CharacterListRendering? { view as? CharacterListRendering }
    
    // MARK: Object lifecycle
    
    init(interactor: CharactersListBusinessLogic,
         adapter: CharacterListAdapting,
         router: CharactersListRouter) {
        self.interactor = interactor
        self.adapter = adapter
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This should only be used programatically")
    }
    
    // MARK: View lifecycle
    
    override func loadView() {
        view = CharacterListView(tableViewProtocols: adapter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

private extension CharactersListViewController {
    func setupNavigationBar() {
        title = "Characters"
        view.backgroundColor = .paleGreen
    }
}


// MARK: - CharactersListDisplayLogic

extension CharactersListViewController: CharactersListDisplayLogic {
    func displayCharactersList(viewModel: CharactersList.PresentCharacters.ViewModel) {
        adapter.configure(characters: viewModel.characters)
        DispatchQueue.main.async {
            self.characterList?.reloadData()
        }
    }
}

protocol CharactersViewDelegateProtocol {
    func displayCharacterDetails(character: Character)
    func loadData()
    func shouldAnimateLoading() -> Bool
}

extension CharactersListViewController: CharactersViewDelegateProtocol {
    
    func displayCharacterDetails(character: Character) {
        router.routeToCharacterDetail(character)
    }
    
    func loadData() {
        let request = CharactersList.PresentCharacters.Request()
        interactor.getCharactersList(request)
    }
    
    func shouldAnimateLoading() -> Bool {
        interactor.shouldAnimate
    }
}
