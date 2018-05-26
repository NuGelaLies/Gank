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
    
    //正在刷新事件
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
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            } else {
                refresh.beginRefreshing()
            }
        }
    }
}



enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case endAllRefresh
    case footerStatus(isHidden: Bool, isNoMoreData: Bool)
}

protocol Refreshable {
    var refreshStatus: BehaviorSubject<RefreshStatus> { get }
}

extension Refreshable {
    func refreshStatusBind(to scrollView: UIScrollView, _ header: ActionHander? = nil, _ footer: ActionHander? = nil) -> Disposable {
        
        if header != nil {
            scrollView.mj_header = MJRefreshNormalHeader {
                // 处理头部方法时结束尾部刷新。
                //scrollView.mj_footer?.endRefreshing()
                header?()
            }
        }
        if footer != nil {
            scrollView.mj_footer = MJRefreshAutoStateFooter {
                // 处理尾部方法时结束头部刷新。
                //scrollView.mj_header?.endRefreshing()
                footer?()
            }
        }
        
        return refreshStatus.asObservable().subscribeNext({ (status) in
            switch status {
            case .none:
                // 未发生任何状态事件时隐藏尾部。
                scrollView.mj_footer.isHidden = true
            case .beingHeaderRefresh:
                scrollView.mj_header.beginRefreshing()
            case .beingFooterRefresh:
                scrollView.mj_footer.beginRefreshing()
            case .endHeaderRefresh:
                scrollView.mj_header.endRefreshing()
            case .endFooterRefresh:
                scrollView.mj_footer.endRefreshing()
            case .endAllRefresh:
                // 结束全部拉刷新
                scrollView.mj_header.endRefreshing()
                scrollView.mj_footer.endRefreshing()
            case .footerStatus(let isHidden, let isNone):
                // 根据关联值确定 footer 的状态。
                scrollView.mj_footer.isHidden = isHidden
                scrollView.mj_header.endRefreshing()
                if isNone {
                    scrollView.mj_footer.endRefreshingWithNoMoreData()
                }else {
                    scrollView.mj_footer.endRefreshing()
                }
            }
        })
    }
}
