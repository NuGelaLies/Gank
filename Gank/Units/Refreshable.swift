//
//  Refreshable.swift
//  HDD_agent
//
//  Created by NuGelaLiee on 2018/4/24.
//  Copyright © 2018年 深圳微服物流. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

//对MJRefreshComponent增加rx扩展
extension Reactive where Base: MJRefreshComponent {
    
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    //刷新状态
    var isRefreshing: Binder<Bool> {
        return Binder(self.base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            } else {
                refresh.beginRefreshing()
            }
        }
    }
}

