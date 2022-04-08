import UIKit

protocol CharacterListAdapting: UITableViewDataSource & UITableViewDelegate {
    func configure(characters: [Character])
}

final class CharacterTableViewAdapter: NSObject, CharacterListAdapting {

    private var viewModel = [Character]()
    
    func configure(characters: [Character]) {
        viewModel = characters
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell(tableView, at: indexPath, forACellDTO: viewModel[indexPath.row].name)
    }
    
    private func cell(_ tableView: UITableView, at indexPath: IndexPath, forACellDTO ACellDTO: String) -> CharacterTableViewCell {
        let cell = tableView.dequeueCell(CharacterTableViewCell.self, indexPath)
        cell.fill(dto: ACellDTO)
        return cell
    }
}

