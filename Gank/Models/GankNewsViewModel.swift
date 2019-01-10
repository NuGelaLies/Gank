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

typealias GankNewsSection = SectionModel<String, TNNews>

final class GankNewsViewModel {
    
    var tableData: Observable<[GankNewsSection]>
    
    var refreshing: Driver<Bool>
    
    init(input: (headerRefresh: Driver<Void>, disposeBag: DisposeBag)) {
        let header = input.headerRefresh
            .startWith(())
            .flatMapLatest { (_) -> SharedSequence<DriverSharingStrategy, [GankNewsSection]> in
                    return Service.shared.loadDatilyNews()
                                .onMainScheduler()
                                .shareOnce()
                                .asDriver(onErrorJustReturn: [])
                
            }
        
        self.refreshing = header.map {_ in true}
        
        tableData = header.asObservable()
    }
    
    func getNews(to date: String) -> Observable<[GankNewsSection]> {
        return Service.shared.getCategoryNews(to: date)
    }

}
