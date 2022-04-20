import UIKit

enum CharactersListViewFactory {
    static func create() -> UIViewController {
        
        let router = CharactersListRouter()
        let interactor = CharactersListInteractor()
        let adapter = CharacterTableViewAdapter()
        let viewController = CharactersListViewController(interactor: interactor,
                                                          adapter: adapter,
                                                          router: router)
        let presenter = CharactersListPresenter()
        interactor.presenter = presenter
        adapter.injectDelegate(viewController)
        presenter.viewController = viewController
        router.viewController = viewController
        return viewController
    }
}

