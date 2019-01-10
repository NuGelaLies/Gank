//
//  GankCategoryViewModel.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/5/26.
//

import Foundation
import RxSwift
import RxCocoa


final class GNCategoryViewModel: ViewModelType {
    
    struct Input {
        let headerRefresh: Driver<Void>
        let footerRefresh: Driver<Void>
        let category: GNCategory
        let disposebag: DisposeBag
    }
    
    struct Output {
        let tableData: BehaviorRelay<[TNNews]>
        let headerRefreshing: Driver<Bool>
        let footerRefreshing: Driver<Bool>
    }
    
    private let tableData = BehaviorRelay<[TNNews]>(value: [])
    
    func transform(input: Input) -> Output {
        let firstLoads = input.headerRefresh
            .startWith(())
            .flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, [TNNews]> in
                return Service.shared.getCategory(to: input.category)
                    .catchOnEmpty {
                        return Observable<[TNNews]>.empty()
                    }.asDriver(onErrorDriveWith: Driver.empty())
        }
        let loadMore = input.footerRefresh
            .flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, [TNNews]> in
                return Service.shared.loadMore(to: input.category)
                    .catchOnEmpty {
                        return Observable<[TNNews]>.empty()
                    }.asDriver(onErrorDriveWith: Driver.empty())
        }
        
        
        firstLoads
            .drive(tableData)
            .disposed(by: input.disposebag)
        
        loadMore.driveNext { [weak base = self] (items) in
            guard let `self` = base else {return}
            self.tableData.accept(self.tableData.value + items)
        }.disposed(by: input.disposebag)
        
        return Output(tableData: self.tableData,
                      headerRefreshing: firstLoads.map {_ in true},
                      footerRefreshing: loadMore.map {_ in true})
    }
    
}
