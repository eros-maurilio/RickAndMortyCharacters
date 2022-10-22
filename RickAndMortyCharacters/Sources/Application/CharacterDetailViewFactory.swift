import UIKit

enum CharacterDetailViewFactory {
    static func create(with characterID: String, coordinator: MainCoordinator) -> UIViewController {
        let interactor = CharacterDetailInteractor()
        let viewController = CharacterDetailViewController(interactor: interactor)
        let presenter = CharacterDetailPresenter()
        interactor.presenter = presenter
        presenter.viewControler = viewController
        viewController.loadData(characterID: characterID)
        
        return viewController
    }
}
