//
//  ViewModelTypeable.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/25.
//

import Foundation
import RxSwift
import RxCocoa

public protocol TrendingViewModelInputs {
    var loadPageTrigger: Driver<Void> { get }
    var loadNextPageTrigger: Driver<Void> { get }
    func refresh()
}

public protocol TrendingViewModelOutputs {
    var isLoading: Driver<Bool> { get }
    var moreLoading: Driver<Bool> { get }
    var elements: BehaviorRelay<[AnyObject]> { get }
    var selectedViewModel: Driver<AnyObject> { get }
}

public protocol TrendingViewModelType {
    var inputs: TrendingViewModelInputs { get  }
    var outputs: TrendingViewModelOutputs { get }
}
