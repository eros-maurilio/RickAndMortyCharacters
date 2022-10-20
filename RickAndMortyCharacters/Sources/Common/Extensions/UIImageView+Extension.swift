import UIKit

extension UIImageView {
    func from(url: URL, using cacheService: ImageCaching = ImageCache.shared) {
        cacheService.get(from: url) { [weak self] in
            
            guard let self = self
            else { return}
            
            self.image = $0
        }
    }
}
