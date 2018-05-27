import RxCocoa
import RxSwift

protocol SearchEventViewModelProtocol {
    var searchText: BehaviorRelay<String> { get }
    var tappedSearchButton: Signal<Void>! { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var events: BehaviorRelay<[ConnpassEvent]> { get }

    func inject(searchText: Driver<String?>,
                tappedSearchButton: Signal<Void>,
                cancelButtonTapped: Signal<Void>)
}

class SearchEventViewModel: SearchEventViewModelProtocol {
    let searchText = BehaviorRelay<String>(value: "")
    var tappedSearchButton: Signal<Void>!
    var cancelButtonTapped: Signal<Void>!
    var events = BehaviorRelay<[ConnpassEvent]>(value: [ConnpassEvent]())
    var isLoading = BehaviorRelay<Bool>(value: false)

    fileprivate var disposedBag = DisposeBag()
    
//    let searchEventModel: SearchEventModel

    let connpassEventRepository: ConnpassEventRepositoryProtocol

    init(connpassEventRepository: ConnpassEventRepositoryProtocol) {
        self.connpassEventRepository = connpassEventRepository
    }

    func searchEvent() {
        self.connpassEventRepository.fetchEvent(searchText: searchText.value)
            .subscribe(onSuccess: { events in
                self.events.accept(events)
                self.isLoading.accept(false)
            }, onError: { error in
                print("error")
                self.isLoading.accept(false)
            })
            .disposed(by: self.disposedBag)
    }
}
