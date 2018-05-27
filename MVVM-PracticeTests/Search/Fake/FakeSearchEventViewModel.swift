//
//  FakeSearchEventViewModel.swift
//  MVVM-PracticeTests
//
//  Created by Daiki Katayama on 2018/05/28.
//  Copyright © 2018 daiki katayama. All rights reserved.
//

@testable import MVVM_Practice
import RxCocoa
import RxSwift

class FakeSearchEventViewModel: SearchEventViewModelProtocol {
    var searchText: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    var tappedSearchButton: Signal<Void>!
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var events: BehaviorRelay<[ConnpassEvent]> = BehaviorRelay<[ConnpassEvent]>(value: [ConnpassEvent]())

    let disposedBag = DisposeBag()

    func inject(searchText: Driver<String?>,
                tappedSearchButton: Signal<Void>,
                cancelButtonTapped: Signal<Void>)
    {
        self.tappedSearchButton = tappedSearchButton
//        self.cancelButtonTapped = cancelButtonTapped

        searchText
            .drive(onNext: { [unowned self] text in
                self.searchText.accept(text!)
            })
            .disposed(by: disposedBag)

        tappedSearchButton
            .emit(onNext: { [unowned self] in
                self.isLoading.accept(true)
            })
            .disposed(by: disposedBag)
    }
}
