import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let characterListFactoryVC = CharactersListViewFactory.create(coordinator: self)
        navigationController?.setViewControllers([characterListFactoryVC], animated: true)
    }
    
    func navigateToCharacterDetail(_ character: Character) {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
//        EditNameConfigurator.configureModule(viewController: viewController, coordinator: self)
    }
}

