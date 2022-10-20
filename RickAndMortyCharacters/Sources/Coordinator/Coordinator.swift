import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}

protocol Coordinating {
    var coordinator : Coordinator? { get set }
}

