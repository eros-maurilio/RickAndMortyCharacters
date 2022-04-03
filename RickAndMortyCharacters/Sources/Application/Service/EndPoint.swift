import Foundation

struct EndPoint {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "api/character"
        
        guard let queryItem = queryItem else {
            return components.url
        }
        
        components.queryItems = queryItem
        
        return components.url
    }
    
    let queryItem: [URLQueryItem]?
    
    init(query: [URLQueryItem]? = nil) {
        self.queryItem = query
    }
}
