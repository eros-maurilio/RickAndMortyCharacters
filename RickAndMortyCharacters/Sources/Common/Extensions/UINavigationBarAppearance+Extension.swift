import UIKit

extension UINavigationBarAppearance {
    func customAppearance() {
        self.configureWithOpaqueBackground()
        self.backgroundColor = .deepGreen
        self.titleTextAttributes = [.foregroundColor: UIColor.neonGreen!, NSAttributedString.Key.font: UIFont.shareTechMono(size: 22)]
        
        UINavigationBar.appearance().standardAppearance = self
        UINavigationBar.appearance().compactAppearance = self
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().tintColor = .neonGreen
    
    }
}
