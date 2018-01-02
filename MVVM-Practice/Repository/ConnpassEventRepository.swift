import RxSwift

class ConnpassEventRepository {
    let disposeBag = DisposeBag()
    
    func fetchEvent(searchText: String) -> Single<[Event]> {
        return Single.create { single in
            var components = URLComponents(string: "https://connpass.com/api/v1/event/")
            components?.queryItems = [
                URLQueryItem(name: "keyword", value: searchText),
                URLQueryItem(name: "count", value: "20")
            ]
            let url = components?.url
            let task = URLSession.shared.dataTask(with: url!) { maybeData, maybeResponse, maybeError in
                if
                    maybeError == nil,
                    let data = maybeData,
                    let response = maybeResponse as? HTTPURLResponse,
                    response.statusCode < 400
                {
                    let responseJson = try! JSONDecoder().decode(Response.self, from: data)
                    single(.success(responseJson.events))
                } else {
                    single(.error(maybeError!))
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
