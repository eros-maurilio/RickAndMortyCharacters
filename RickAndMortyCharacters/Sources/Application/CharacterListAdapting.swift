import UIKit

protocol CharacterListAdapting: UITableViewDataSource & UITableViewDelegate {
    func configure(characters: [Character])
    func injectDelegate(_ delegate: CharactersViewDelegateProtocol)
}

enum TableSectionType: Int {
    case characterRow, loading
    
    static func sectionsCount() -> Int { [TableSectionType.loading, TableSectionType.characterRow].count }
}

final class CharacterTableViewAdapter: NSObject, CharacterListAdapting {
    private var rowLimit: Int = .zero
    private var viewModel = [Character]()
    private var delegate: CharactersViewDelegateProtocol?
    private var shouldLoad = true
    
    func configure(characters: [Character]) {
        viewModel = characters
    }
    
    func injectDelegate(_ delegate: CharactersViewDelegateProtocol) {
        self.delegate = delegate
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { TableSectionType.sectionsCount() }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSectionType(rawValue: section) else { return .zero }
        
        switch listSection {
        case .characterRow:
            return viewModel.count
        case .loading:
            return viewModel.count >= rowLimit ? 1 : .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listSection = TableSectionType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch listSection {
        case .characterRow:
            return characterCell(tableView, at: indexPath, forACellDTO: viewModel[indexPath.row])
        case .loading:
            let cell = loadingCell(tableView, cellForRowAt: indexPath)
            shouldLoad ? cell.startLoading() : cell.stopLoading()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSectionType(rawValue: indexPath.section) else { return }
        
        let penultRow = viewModel.count - 1
        
        if section == .loading {
            shouldLoad = delegate!.shouldAnimateLoading()
            if shouldLoad { delegate?.loadData() }
        }
        
        if indexPath.row == penultRow { rowLimit = indexPath.row }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.displayCharacterDetails(characterID: viewModel[indexPath.row].id)
    }
    
    private func characterCell(_ tableView: UITableView, at indexPath: IndexPath, forACellDTO ACellDTO: Character) -> CharacterCell {
        let cell = tableView.dequeueCell(CharacterCell.self, indexPath)
        cell.fill(dto: ACellDTO)
        return cell
    }
    
    private func loadingCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> LoadingCell {
        let cell = tableView.dequeueCell(LoadingCell.self, indexPath)
        
        return cell
    }
}

