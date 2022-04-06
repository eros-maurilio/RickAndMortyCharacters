import UIKit

protocol CharactersListDisplayLogic: AnyObject {
    func displayCharactersList(viewModel: CharactersList.UseCase.ViewModel)
}

class CharactersListViewController: UIViewController {
    var interactor: CharactersListBusinessLogic?
    var router: (NSObjectProtocol & CharactersListRoutingLogic & CharactersListDataPassing)?
    var tableView = UITableView()
    
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
        setupTableView()
        setupNavigationBar()
        loadData()
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
//        router.dataStore = interactor
    }
    
    func loadData() {
        let request = CharactersList.UseCase.Request()
        interactor?.getCharactersList(request)
    }
    
    func setupTableView() {
        tableView = UITableView()
        setupTableViewContraints()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
    }
    
    func setupNavigationBar() {
        title = "Characters"
        view.backgroundColor = .orange
    }
    
    func setupTableViewContraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}


// MARK: - CharactersListDisplayLogic

extension CharactersListViewController: CharactersListDisplayLogic {
    func displayCharactersList(viewModel: CharactersList.UseCase.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

extension CharactersListViewController: UITableViewDelegate {
    
}

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     UITableViewCell()
    }
}
