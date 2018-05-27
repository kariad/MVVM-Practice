import RxSwift
import RxCocoa

class SearchEventModel {
    let repository: ConnpassEventRepositoryProtocol
    
    init(repository: ConnpassEventRepositoryProtocol) {
        self.repository = repository
    }
    
    func search(text: String) -> Single<[ConnpassEvent]> {
        return repository.fetchEvent(searchText: text)
    }
}
