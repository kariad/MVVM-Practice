import RxSwift
import RxCocoa

class SearchEventModel {
    let events = BehaviorRelay<[ConnpassEvent]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isError = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    let repository: ConnpassEventRepositoryProtocol
    
    init(repository: ConnpassEventRepositoryProtocol) {
        self.repository = repository
    }
    
    func search(text: String) {
        self.isLoading.accept(true)
        self.repository.fetchEvent(searchText: text)
            .subscribe(
                onSuccess: { [unowned self] events in
                    self.events.accept(events)
                    self.isLoading.accept(false)
                },
                onError: { [unowned self] error in
                    self.isError.accept(true)
                    self.isLoading.accept(false)
                }
            )
            .disposed(by: self.disposeBag)
    }
}
