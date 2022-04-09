import UIKit

extension UIFont {
    
    static func shareTechMono(size fontSize: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: Strings.FontName.ShareTechMono, size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        
        return customFont.withSize(fontSize)
    }
    
    static func shareTech(size fontSize: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: Strings.FontName.ShareTech, size: fontSize) else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        
        return customFont.withSize(fontSize)
    }
}
