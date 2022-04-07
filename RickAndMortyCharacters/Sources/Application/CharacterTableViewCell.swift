import UIKit

class CharacterTableViewCell: UITableViewCell {
    private lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(dto: String) {
        name.text = dto
    }
}

private extension CharacterTableViewCell {
    func setupConstraints() {
        name.translatesAutoresizingMaskIntoConstraints = false
        addSubview(name)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            name.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            name.rightAnchor.constraint(equalTo: rightAnchor, constant: -15)
        ])
    }
    
    func setupView() {
        self.backgroundColor = . clear
    }
}
