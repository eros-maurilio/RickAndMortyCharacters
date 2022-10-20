import UIKit

protocol CharacterListRendering {
    func reloadData()
}

final class CharacterListView: UIView, CharacterListRendering {
    private let tableView = UITableView()
    
    init(tableViewProtocols: CharacterListAdapting, frame: CGRect = .zero) {
        super.init(frame: frame)
        setupTableView(tableViewProtocols: tableViewProtocols)
        rowSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView(tableViewProtocols: CharacterListAdapting) {
        setupTableViewContraints()
        tableView.dataSource = tableViewProtocols
        tableView.delegate = tableViewProtocols
        tableView.backgroundColor = .clear
        tableView.register(CharacterCell.self)
        tableView.register(LoadingCell.self)
    }
    
    private func setupTableViewContraints() {
        addSubview(tableView)
        tableView.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
            $0.leftAnchor.constraint(equalTo: leftAnchor)
            $0.rightAnchor.constraint(equalTo: rightAnchor)
        }
        
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func rowSetup() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset =  UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
    }
}
