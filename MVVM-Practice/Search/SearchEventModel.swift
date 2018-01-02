import RxSwift
import RxCocoa

class SearchEventModel {
    let events = BehaviorRelay<[Event]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isError = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    func search(text: String) {
        self.isLoading.accept(true)
        let repository = ConnpassEventRepository()
        repository.fetchEvent(searchText: text)
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
