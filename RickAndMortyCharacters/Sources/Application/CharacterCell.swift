import UIKit

class CharacterCell: UITableViewCell {
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.shareTech(size: 19)
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var characterImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.image = UIImage(named: "BethSmith")
        imageView.backgroundColor = .paleGreen
        imageView.contentMode = .scaleAspectFill
        imageView.applyCornerRadius(10)
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var cellBackground = UIView()
    
    private lazy var chevronIcon: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 8, height: 11))
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        
        return imageView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
        setupCellBackground()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(dto: Character) {
        name.text = dto.name
        characterImage.from(url: URL(string: dto.imageURL)!)
    }
}

private extension CharacterCell {
    
    func setupConstraints() {
        contentView.addSubview(cellBackground)
        cellBackground.addSubview(name)
        cellBackground.addSubview(characterImage)
        cellBackground.addSubview(chevronIcon)
        
        cellBackground.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            $0.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15)
            $0.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        }
        
        characterImage.layout {
            $0.topAnchor.constraint(greaterThanOrEqualTo: cellBackground.topAnchor, constant: 10)
            $0.leftAnchor.constraint(equalTo: cellBackground.leftAnchor, constant: 10)
            $0.bottomAnchor.constraint(lessThanOrEqualTo: cellBackground.bottomAnchor, constant: -10)
            $0.widthAnchor.constraint(equalToConstant: 50)
            $0.heightAnchor.constraint(equalToConstant: 50)
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        }
        
        name.layout {
            $0.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 10)
            $0.leftAnchor.constraint(equalTo: characterImage.rightAnchor, constant: 20)
            $0.rightAnchor.constraint(lessThanOrEqualTo: chevronIcon.leftAnchor, constant: -20)
            $0.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -10)
        }
        
        chevronIcon.layout {
            $0.centerYAnchor.constraint(equalTo: characterImage.centerYAnchor)
            $0.rightAnchor.constraint(equalTo: cellBackground.rightAnchor, constant: -10)
        }
    }
    
    func setupView() {
        self.backgroundColor = . clear
    }
    
    func setupCellBackground() {
        cellBackground.backgroundColor = .deepGreen
        cellBackground.applyCornerRadius(10)
        cellBackground.applyShadow()
    }
}
