import UIKit

final class CharacterDetailView: UIView {
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .neonGreen
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    lazy var characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var imageHolder: UIView = {
        let view = UIView()
        view.addSubview(characterImage)
        characterImage.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        }
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neonGreen
        label.font = UIFont.shareTech(size: 40)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.applyShadow()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var statusView: StatusView = {
        let view = StatusView()
        return view
    }()
    
    lazy var specsView: SpecsView = {
        let view = SpecsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cretedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .paleGreen
        label.font = UIFont.shareTechMono(size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    weak var viewController: CharacterDetailViewController?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .deepGreen
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.layout {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            $0.widthAnchor.constraint(equalTo: widthAnchor)
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        
        contentView.layout {
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor)
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        }
    }
    
    func setupView() {
        setupScrollView()
        addSubview(loadingIndicator)
        addSubview(backButton)
        contentView.addSubview(imageHolder)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusView)
        contentView.addSubview(specsView)
        contentView.addSubview(cretedLabel)
        
        backButton.layout {
            $0.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        }
        
        loadingIndicator.layout {
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: centerYAnchor)
        }
        
        imageHolder.viewAspectRatio(1.0/1.0).isActive = true
        
        imageHolder.layout {
            $0.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 45)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70)
        }
        
        nameLabel.layout {
            $0.topAnchor.constraint(equalTo: imageHolder.bottomAnchor, constant: 68)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45)
        }
        
        statusView.layout {
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            $0.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16)
        }
    
        specsView.layout {
            $0.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 40)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45)
        }
        
        cretedLabel.layout {
            $0.topAnchor.constraint(equalTo: specsView.bottomAnchor, constant: 45)
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45)
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        }
    }
    
    func configure(character: CharacterDetail.Character) {
        characterImage.from(url: URL(string: character.image)!)
        characterImage.layer.cornerRadius = characterImage.frame.height / 2
        imageHolder.applyShadow()
        nameLabel.text = character.name
        statusView.configure(type: StatusView.StatusType(rawValue: character.status) ?? .unknow)
        specsView.setupView(with: character)
        cretedLabel.text = character.created
        loadingIndicator.stopAnimating()
    }
    
    @objc
    func goBack() {
        viewController?.dismissView()
    }
}


