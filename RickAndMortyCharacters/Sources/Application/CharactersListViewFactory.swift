import UIKit

enum CharactersListViewFactory {
    static func create() -> UIViewController {
        
        let router = CharactersListRouter()
        let adapter = CharacterTableViewAdapter()
        let interactor = CharactersListInteractor()
        let viewController = CharactersListViewController(interactor: interactor,
                                                          adapter: adapter,
                                                          router: router)
        let presenter = CharactersListPresenter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}

