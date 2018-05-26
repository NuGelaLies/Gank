//
//  Refreshable.swift
//  HDD_agent
//
//  Created by NuGelaLiee on 2018/4/24.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh

extension Reactive where Base: MJRefreshComponent {
    
    var refreshing: ControlEvent<Void> {
        let source = Observable<Void>.create { [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    
    var endRefreshing: Binder<Bool> {
        return Binder(self.base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            } else {
                refresh.beginRefreshing()
            }
        }
    }
}
