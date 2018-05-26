//
//  GankCategoryViewModel.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/5/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class GankCategoryViewModel {
    
    let tableData = BehaviorRelay<[TNNews]>(value: [])
    
    var page = 1
    
    let category: BehaviorRelay<GNCategory>
    
    let headerRefreshing: Driver<Bool>
    
    let footerRefreshing: Driver<Bool>
    
    private let service: NetworkService
    
    init(
        input: (headerRefresh: Driver<Void>, footerRefresh: Driver<Void>, category: GNCategory),
        dependency: (service: NetworkService, dispiseBag: DisposeBag)) {
        
        let headerRefresh = input.headerRefresh
            .startWith(())
            .flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, [TNNews]> in
                return dependency.service.getCategory(to: input.category)
                    .catchOnEmpty {
                        return Observable<[TNNews]>.empty()
                    }.asDriver(onErrorDriveWith: Driver.empty())
                
        }
        let footerRefresh = input.footerRefresh
            .startWith(())
            .flatMapLatest { _ -> SharedSequence<DriverSharingStrategy, [TNNews]> in
                return dependency.service.loadMore(to: input.category)
                    .catchOnEmpty {
                        return Observable<[TNNews]>.empty()
                    }.asDriver(onErrorDriveWith: Driver.empty())
                
        }
        self.headerRefreshing = input.headerRefresh.map {_ in true}
        self.footerRefreshing = input.footerRefresh.map {_ in true}
        self.service = dependency.service
        self.category = BehaviorRelay(value: input.category)
        
        headerRefresh.asDriver()
            .driveNext { [weak vm = self] (items) in
                vm?.tableData.accept(items)
            }.disposed(by: dependency.dispiseBag)
        
        footerRefresh.asDriver()
            .driveNext { [weak vm = self] (items) in
                if let v = vm {
                    v.tableData.accept(v.tableData.value + items)
                }
            }.disposed(by: dependency.dispiseBag)
    }
    
    func getCategory(form category: GNCategory) -> SharedSequence<DriverSharingStrategy, [TNNews]> {
            return service.getCategory(to: category)
                      .catchOnEmpty {
                        return Observable<[TNNews]>.empty()
                    }.asDriver(onErrorDriveWith: Driver.empty())
    }
}
