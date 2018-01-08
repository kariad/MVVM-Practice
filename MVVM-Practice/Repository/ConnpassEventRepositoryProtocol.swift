import RxSwift

protocol ConnpassEventRepositoryProtocol {
    func fetchEvent(searchText: String) -> Single<[ConnpassEvent]>
}
