//
//  GankCategoryViewModel.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/5/26.
//

import Foundation
import RxSwift
import RxCocoa

protocol GNCategoryViewModelInputs {
    var headerRefresh: PublishSubject<Void> {get}
    var footerRefresh: PublishSubject<Void> {get}
}

protocol GNCategoryViewModelOutputs {
    var tableData: BehaviorRelay<[TNNews]> {get}
    var endHeaderRefresh: Observable<Bool> {get}
    var endFooterRefresh: Observable<Bool> {get}
}

protocol GNCategoryViewModelType {
    var inputs:  GNCategoryViewModelInputs { get }
    var outputs: GNCategoryViewModelOutputs { get }
    
}

final class GNCategoryViewModel {
    
    var inputs:  GNCategoryViewModelInputs { return self }
    var outputs: GNCategoryViewModelOutputs { return self }
    
    private var category: GNCategory!
    private var categoryValue: GNCategory = .App
    private var page = 1
    private let disposedBag = DisposeBag()
    init(serice: Service = .init(), category: GNCategory) {
        
        let hRefresh = PublishSubject<Void>()
        
        let fRefresh = PublishSubject<Void>()
        
        self.headerRefresh = hRefresh
        self.footerRefresh = fRefresh
        
        self.category = category

        let firstLoads = hRefresh
            .flatMapLatest { _ -> Observable<[TNNews]> in
                return serice.getCategory(to: category)
                    .catchErrorJustReturn([])
        }
        let loadMore = fRefresh
            .flatMapLatest { _ -> Observable<[TNNews]> in
                return serice.loadMore(to: category)
                    .catchErrorJustReturn([])
        }
        
        self.endHeaderRefresh = firstLoads.map {_ in true}
        
        self.endFooterRefresh = loadMore.map {_ in true}
        
        firstLoads.subscribeNext { [weak self] (items) in
            guard let `self` = self else {return}
            self.tableData.accept(items)
        }.disposed(by: disposedBag)
        
        loadMore.subscribeNext { [weak self] (items) in
            guard let `self` = self else {return}
            self.tableData.accept(self.tableData.value + items)
        }.disposed(by: disposedBag)
    }

    //MARK: - inputs
    var headerRefresh: PublishSubject<Void>
    var footerRefresh: PublishSubject<Void>
    
    //MARK: - outputs
    var tableData = BehaviorRelay<[TNNews]>(value: [])
    var endFooterRefresh: Observable<Bool> = .empty()
    var endHeaderRefresh: Observable<Bool> = .empty()
    
}

extension GNCategoryViewModel: GNCategoryViewModelInputs, GNCategoryViewModelOutputs, GNCategoryViewModelType {}

