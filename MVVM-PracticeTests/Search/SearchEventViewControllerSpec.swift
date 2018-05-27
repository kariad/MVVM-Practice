//
//  SearchEventViewControllerSpec.swift
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

class SearchEventViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: SearchEventViewController!
        var fakeViewModel: FakeSearchEventViewModel!
        var fakeRouter: FakeRouter!

        beforeEach {
            fakeRouter = FakeRouter()
            fakeViewModel = FakeSearchEventViewModel()
            subject = SearchEventViewController(router: fakeRouter, searchEventViewModel: fakeViewModel)
        }

        describe("tapped search button") {
            it("displays event") {

                expect(subject.events.count).to(equal(3))
            }
        }
    }
}
