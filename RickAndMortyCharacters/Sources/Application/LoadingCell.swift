import UIKit

class LoadingCell: UITableViewCell {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .neonGreen
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}

private extension LoadingCell {
    func setupContentView() {
        self.backgroundColor = .clear
    }
    
    func setupConstraints() {
        contentView.addSubview(activityIndicator)
        
        activityIndicator.layout {
            $0.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30)
            $0.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
            $0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            $0.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        }
    }
}
