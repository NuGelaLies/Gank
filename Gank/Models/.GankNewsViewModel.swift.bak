//
//  GankNewsViewModel.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class GankNewsViewModel {
    let tableData = BehaviorRelay<[SectionModel<String, TNNews>]>(value: [])
    
    var refreshing: Driver<Bool>
    
    init(input: (headerRefresh: Driver<Void>, disposeBag: DisposeBag)) {
        let header = input.headerRefresh
            .startWith(())
            .flatMapLatest { (_) -> SharedSequence<DriverSharingStrategy, [SectionModel<String, TNNews>]> in
                    return Service.shared.loadDatilyNews()
                                .onMainScheduler()
                                .asDriver(onErrorJustReturn: [])
                
            }
        
        self.refreshing = header.map {_ in true}
        
        header.driveNext { [weak self] (items) in
            self?.tableData.accept(items)
            }.disposed(by: input.disposeBag)
    }
    
    func getNews(to date: String) -> Observable<[SectionModel<String, TNNews>]> {
        return Service.shared.getCategoryNews(to: date)
    }

}
