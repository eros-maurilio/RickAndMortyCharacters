import UIKit

extension UIView {
    func layout(@ConstraintCollector _ constraints: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints(self))
    }
    
    func applyCornerRadius(_ cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
    }
    
    func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 2, height: 4)
        layer.shadowRadius = 3
    }
    
    func viewAspectRatio(_ ratio: CGFloat) -> NSLayoutConstraint {
    NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}

@resultBuilder
struct ConstraintCollector {
    static func buildBlock(_ components: NSLayoutConstraint...) -> [NSLayoutConstraint] {
        components
    }
}
