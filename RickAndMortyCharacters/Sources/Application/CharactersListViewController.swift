import UIKit

protocol CharactersListDisplayLogic: AnyObject {
    func displaySomething(viewModel: CharactersList.Something.ViewModel)
}

class CharactersListViewController: UIViewController {
    var interactor: CharactersListBusinessLogic?
    var router: (NSObjectProtocol & CharactersListRoutingLogic & CharactersListDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIP()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIP()
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }
}

private extension CharactersListViewController {
    
    func setupVIP() {
        let viewController = self
        let interactor = CharactersListInteractor()
        let presenter = CharactersListPresenter()
        let router = CharactersListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func doSomething() {
        let request = CharactersList.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func setupTableView() { }
}


// MARK: - CharactersListDisplayLogic

extension CharactersListViewController: CharactersListDisplayLogic {
    func displaySomething(viewModel: CharactersList.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
