import Foundation

final class NetworkDataLoaderManager {
    
    private var sharedSession: URLSession { URLSession.shared }
    
    func execute<T: Decodable>(_ endPoint: EndPoint, completion: @escaping(Result<T, NSError>) -> Void) {
        guard let url = endPoint.url else {
            return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Incorret URL"])))
        }
        
        let task = sharedSession.dataTask(with: url) { data, _, error in
            if let error = error {
                return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": error.localizedDescription])))
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Unable to get data"])))
            }
            
            do {
                let genericData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(genericData))
                
            } catch {
                completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Can't parse JSON"])))
            }
        }
        task.resume()
    }
}
