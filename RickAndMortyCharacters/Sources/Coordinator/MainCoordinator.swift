import UIKit

final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    func start() {
        let characterListFactoryVC = CharactersListViewFactory.create(coordinator: self)
        navigationController?.setViewControllers([characterListFactoryVC], animated: true)
    }
    
    func navigateToCharacterDetail(_ characterID: Int) {
        let viewController = CharacterDetailViewFactory.create(with: String(characterID), coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

