import Foundation

struct Character: Decodable {
    let name: String
    let id: Int
}

final class CharactersListWorker {
    typealias ListResult = Result<[Character], NSError>
    private var model = [Character]()
    
    func execute(withQuery query: String) -> [Character] {
        let dataLoaderManager = DataLoaderManager()
        
        dataLoaderManager.execute(.requestURLWith(.page, query: query)) { [weak self] (result: ListResult) in
                    
            guard let self = self else { return }
            
            switch result {
            case let .success(data):
                self.model = data
                print(self.model)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
        return model
    }
}
