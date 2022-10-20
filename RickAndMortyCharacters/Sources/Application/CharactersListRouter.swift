import UIKit

protocol CharacterListRouterProtocol {
    var coordinator: MainCoordinator? { get }
    func routeToCharacterDetail(_ character: Character)
}

class CharactersListRouter: CharacterListRouterProtocol {
    var coordinator: MainCoordinator?
    
    func routeToCharacterDetail(_ character: Character) {
        coordinator?.navigateToCharacterDetail(character)
    }
    
    // MARK: Navigation
    
    func navigateToCharacterDetail(source: CharactersListViewController, destination: UIViewController) {
        source.show(destination, sender: nil)
    }
}
