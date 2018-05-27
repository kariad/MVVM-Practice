//
//  SearchEventViewModelSpec.swift
//  MVVM-PracticeTests
//
//  Created by Daiki Katayama on 2018/05/28.
//  Copyright © 2018 daiki katayama. All rights reserved.
//

@testable import MVVM_Practice
import Quick
import Nimble
import RxSwift
import RxCocoa

class SearchEventViewModelSpec: QuickSpec {
    override func spec() {
        var subject: SearchEventViewModel!
        var fakeConnpassEventRepository: FakeConnpassEventRepository!

        beforeEach {
            fakeConnpassEventRepository = FakeConnpassEventRepository()
            subject = SearchEventViewModel(
                connpassEventRepository: fakeConnpassEventRepository
            )
        }

        describe("search evnet") {
            context("when success") {
                let connpassEvent = ConnpassEvent(
                    title: "社内LT大会",
                    catchCopy: "",
                    eventUrl: "oisix.com",
                    startedAt: "5/28"
                )
                let expectEvents: [ConnpassEvent] = [connpassEvent]
                beforeEach {
                    let successSingle: Single<[ConnpassEvent]> = Single.create { single in
                        single(.success(expectEvents))
                        return Disposables.create()
                    }
                    fakeConnpassEventRepository.connpassEvents = successSingle
                }
                it("update to event") {
                    subject.searchEvent()


                    expect(subject.events.value[0].title).to(equal(expectEvents[0].title))
                }
                it("isLoading to be false") {
                    subject.searchEvent()


                    expect(subject.isLoading.value).to(beFalse())
                }
            }
        }
    }
}
