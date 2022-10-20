import UIKit

protocol ImageCaching {
    func get(from url: URL, setImage: @escaping(UIImage?) -> Void)
}

final class ImageCache: ImageCaching {
    private let imageCache = NSCache<NSString, UIImage>()
    private var taskPool: NSCache<NSString, URLSessionDataTask> = .init()
    
    static let shared = ImageCache()
    
    private init() {}
    
    func get(from url: URL, setImage: @escaping (UIImage?) -> Void) {
        let cachingKey = url.absoluteString as NSString
        setImage(nil)
        
        if let cachedImage = imageCache.object(forKey: cachingKey) {
            setImage(cachedImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                debugPrint(error)
                return
            }
            
            guard let data = data
            else { return }
            
            DispatchQueue.main.async {
                setImage(UIImage(named: "BethSmith"))
                if let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: cachingKey)
                    setImage(image)
                }
                self.taskPool.removeObject(forKey: cachingKey)
            }
        }
        taskPool.setObject(task, forKey: cachingKey)
        task.resume()
    }
}
