import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: "BethSmith")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var cellBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupCellBackground()
        setupConstraints()
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
        contentView.addSubview(cellBackground)
        cellBackground.addSubview(name)
        cellBackground.addSubview(characterImage)
        
        NSLayoutConstraint.activate([
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cellBackground.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            cellBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(greaterThanOrEqualTo: cellBackground.topAnchor, constant: 10),
            characterImage.leftAnchor.constraint(equalTo: cellBackground.leftAnchor, constant: 10),
            characterImage.bottomAnchor.constraint(lessThanOrEqualTo: cellBackground.bottomAnchor, constant: -10),
            characterImage.widthAnchor.constraint(equalToConstant: 50),
            characterImage.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 10),
            name.leftAnchor.constraint(equalTo: characterImage.rightAnchor, constant: 10),
            name.rightAnchor.constraint(equalTo: cellBackground.rightAnchor, constant: -15),
            name.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -10)
        ])
    }
    
    func setupView() {
        self.backgroundColor = . clear
    }
    
    func setupCellBackground() {
        cellBackground.backgroundColor = .blue
        cellBackground.layer.cornerRadius = 10
    }
}
