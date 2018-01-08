import RxSwift
@testable import MVVM_Practice

class FakeConnpassEventRepository: ConnpassEventRepositoryProtocol {
    var connpassEvents: Single<[ConnpassEvent]>!
    func fetchEvent(searchText: String) -> Single<[ConnpassEvent]> {
        return self.connpassEvents
    }
}
