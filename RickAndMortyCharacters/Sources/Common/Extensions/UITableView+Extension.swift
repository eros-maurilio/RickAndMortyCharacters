import UIKit

extension UITableView {
    func dequeueCell<T>(_ : T.Type, _ indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("No cell of type \(T.self) registered for table view \(self)")
        }
        return cell
    }
    
    func register<T>(_ : T.Type) where T: UITableViewCell {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
}

private extension UITableViewCell {
    static var identifier: String { String(describing: self) }
}

