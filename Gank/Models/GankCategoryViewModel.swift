//
//  GankCategoryViewModel.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/5/26.
//

import Foundation
import RxSwift
import RxCocoa

final class GankCategoryViewModel {
    
    let tableData = BehaviorRelay<[TNNews]>(value: [])
        
    let headerRefreshing: Driver<Bool>
    
    let footerRefreshing: Driver<Bool>
    
    init(
        input: (headerRefresh: Driver<Void>, footerRefresh: Driver<Void>, category: GNCategory),
        disposeBag: DisposeBag) {
        
        let headerRefresh = input.headerRefresh
            .startWith(())
            .flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, [TNNews]> in
                return Service.shared.getCategory(to: input.category)
                    .catchOnEmpty {
                        return Observable<[TNNews]>.empty()
                    }.asDriver(onErrorDriveWith: Driver.empty())
                
        }
        let footerRefresh = input.footerRefresh
            .flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, [TNNews]> in
                return Service.shared.loadMore(to: input.category)
                    .catchOnEmpty {
                        return Observable<[TNNews]>.empty()
                    }.asDriver(onErrorDriveWith: Driver.empty())
                
                
        }
        self.headerRefreshing = headerRefresh.map {_ in true}
        self.footerRefreshing = footerRefresh.map {_ in true}
        
        headerRefresh.asDriver()
            .driveNext { [weak vm = self] (items) in
                vm?.tableData.accept(items)
            }.disposed(by: disposeBag)
        
        footerRefresh.asDriver()
            .driveNext { [weak vm = self] (items) in
                if let v = vm {
                    v.tableData.accept(v.tableData.value + items)
                }
            }.disposed(by: disposeBag)
    }
    
}
