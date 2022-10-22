import UIKit

protocol CharacterListRouterProtocol {
    var coordinator: MainCoordinator? { get }
    func routeToCharacterDetail(_ characterID: Int)
}

class CharactersListRouter: CharacterListRouterProtocol {
    var coordinator: MainCoordinator?
    
    func routeToCharacterDetail(_ characterID: Int) {
        coordinator?.navigateToCharacterDetail(characterID)
    }
    
    // MARK: Navigation
    
    func navigateToCharacterDetail(source: CharactersListViewController, destination: UIViewController) {
        source.show(destination, sender: nil)
    }
}
