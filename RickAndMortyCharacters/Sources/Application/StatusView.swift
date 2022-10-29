import UIKit

final class StatusView: UIView {
    enum StatusType: String {
        case alive, dead, unknow
        
        static func getStatus() -> [StatusType] { [.alive, .dead, .unknow]}
    }
    
    lazy var stackView: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .fill
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fill
        
        return stack
    }()
    
    private var type: StatusType = .unknow
    
    func configure(type: StatusType) {
        self.type = type
        setupView()
    }
    
    func setupView() {
        addSubview(stackView)
        stackView.clipsToBounds = false
        
        stackView.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
        
        let status = StatusType.getStatus()
        status.forEach {
            let item = $0 == type ? makeStatusItem($0, isSelected: true) : makeStatusItem($0, isSelected: false)
            stackView.addArrangedSubview(item)
        }
    }
    
    func makeStatusItem(_ status: StatusType, isSelected: Bool) -> UIView {
        let view = UIView()
        let label = UILabel()
        label.text = status.rawValue.firstUppercased
        label.textColor = isSelected ? .deepGreen : .white.withAlphaComponent(0.5)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.shareTechMono(size: 12)        
        view.addSubview(label)
        
        view.layout {
            $0.widthAnchor.constraint(equalToConstant: 64)
        }
        
        label.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 4)
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4)
        }
        
        view.layer.cornerRadius = 5
        view.applyShadow()
        view.backgroundColor = isSelected ? .neonGreen : .paleGreen
        
        return view
    }
}
