import UIKit

final class SpecsView: UIView {
    
    struct Spec {
        let type: SpecType
        let body: String
    }
    
    enum SpecType: String {
        case species, type, gender, origin, location
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.spacing = 30
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    var specs: [Spec] = []
    
    func setupView(with character: CharacterDetail.Character) {
        getSpecs(characterDetail: character)
        addSubview(stackView)

        specs.forEach {
            stackView.addArrangedSubview(createItemView(for: $0))
        }
        
        stackView.layout {
            $0.topAnchor.constraint(equalTo: topAnchor)
            $0.leadingAnchor.constraint(equalTo: leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }
    
    func getSpecs(characterDetail: CharacterDetail.Character) {
        if let specie = characterDetail.species {
            specs.append(Spec(type: .species, body: specie))
        }
        
        if let type = characterDetail.type, !type.isEmpty {
            specs.append(Spec(type: .type, body: type))
        }
        
        if let gender = characterDetail.gender {
            specs.append(Spec(type: .gender, body: gender))
        }
        
        if let origin = characterDetail.origin {
            specs.append(Spec(type: .species, body: origin.name))
        }
        
        if let location = characterDetail.location {
            specs.append(Spec(type: .location, body: location.name))
        }
    }
    
    
    func createItemView(for spec: Spec) -> UIView {
        let view = UIView()
        let title = createTitle(type: spec.type)
        let descriptionBlock = createDescriptionBlock(for: spec)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)
        view.addSubview(descriptionBlock)
        
        title.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        }
        
        descriptionBlock.layout {
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        }
        
        return view
    }
    
    func createDescriptionBlock(for spec: Spec) -> UIView {
        let view = UIView()
        let label = UILabel()
        
        label.text = spec.body
        label.font = .shareTechMono(size: 17)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        
        view.backgroundColor = .paleGreen
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.applyShadow()
        
        view.addSubview(label)
        
        label.layout {
            $0.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        }
        
        return view
    }
    
    func createTitle(type: SpecType) -> UILabel {
        let label = UILabel()
        label.text = type.rawValue.firstUppercased
        label.textColor = .neonGreen
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.shareTechMono(size: 18)
        label.applyShadow()
        return label
    }
}
