import RxCocoa
import RxSwift

class SearchEventViewModel {
    let searchText = BehaviorRelay<String>(value: "")
    var searchButtonTapped: Driver<Void>
    var cancelButtonTapped: Driver<Void>
    var events: BehaviorRelay<[Event]>
    var isLoading = BehaviorRelay<Bool>(value: false)
    var disposedBag = DisposeBag()
    
    let searchEventModel = SearchEventModel()
    
    init(searchText: Driver<String?>,
         searchButtonTapped: Driver<Void>,
         cancelButtonTapped: Driver<Void>)
    {
        self.searchButtonTapped = searchButtonTapped
        self.cancelButtonTapped = cancelButtonTapped
        self.events = self.searchEventModel.events
        
        searchText
            .drive(onNext: { [unowned self] text in
                self.searchText.accept(text!)
            })
            .disposed(by: self.disposedBag)
        
        self.searchButtonTapped
            .drive(onNext: { [unowned self] in
                self.searchEventModel.search(text: self.searchText.value)
            })
            .disposed(by: self.disposedBag)
        
        self.cancelButtonTapped
            .drive(onNext: { [unowned self] in
                self.searchText.accept("")
            })
            .disposed(by: self.disposedBag)
        
        self.searchEventModel.isLoading
            .asDriver()
            .drive(self.isLoading)
            .disposed(by: self.disposedBag)
    }
}
