import Foundation

struct EndPoint {
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "rickandmortyapi.com"
        components.path = "/api/character/"
        
        if let extendedPath = extendedPath {
            components.path += extendedPath
        }
        
        guard let queryItem = queryItem else {
            return components.url
        }
        
        components.queryItems = queryItem
        
        return components.url
    }
    
    private let queryItem: [URLQueryItem]?
    private let extendedPath: String?
    
    private init(query: [URLQueryItem]? = nil, extendedPath: String? = nil) {
        self.queryItem = query
        self.extendedPath = extendedPath
    }
}

extension EndPoint {
    enum QueryType: String {
        case status, page
    }
    
    static func requestURLWith(_ queryType: QueryType, query: String) -> EndPoint {
        var currentQuery: URLQueryItem
        
        currentQuery = URLQueryItem(name: queryType.rawValue, value: query)
        
        return EndPoint(query: [currentQuery])

    }
    
    static func requestCharacterURLWith(id: Int) -> EndPoint {
        let formatedID = id.description

        return EndPoint(extendedPath: formatedID)
    }
}
