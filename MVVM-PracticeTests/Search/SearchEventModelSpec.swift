import Quick
import Nimble
import RxSwift
import RxCocoa
import RxBlocking
@testable import MVVM_Practice

class SearchEventModelSpec: QuickSpec {
    var subject: SearchEventModel!
    var fakeRepository: FakeConnpassEventRepository!
    
    override func spec() {
//        beforeEach {
//            self.fakeRepository = FakeConnpassEventRepository()
//            self.subject = SearchEventModel(repository: self.fakeRepository)
//        }

//        describe("search", closure: {
//            context("on success", closure: {
//                it("updated events", closure: {
//                    let events = [ConnpassEvent(title: "testEvent", catchCopy: "hogehoge", eventUrl: "http://event.com", startedAt: "2018-10-10")]
//                    self.fakeRepository.connpassEvents = Single.create { single in
//                        single(.success(events))
//                        return Disposables.create()
//                    }
//
//
//                    self.subject.search(text: "test")
//
//
//                    expect(self.subject.events.value[0].title).to(equal(events[0].title))
//                })
//            })
//        })
    }
}
