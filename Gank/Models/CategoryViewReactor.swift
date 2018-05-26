//
//  CategoryViewReactor.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/4/17.
//

import ReactorKit
import RxSwift

final class CategoryViewReactor: Reactor {
    // 用户行为
    enum Action {
        case refresh(GNCategory)
        case loadMore(GNCategory)
    }
    
    // 用户行为转换为界面状态的中间
    enum Mutation {
        case loadFirstData([TNNews])
        case isloading(Bool)
        case loadMoreData([TNNews])
    }
    
    // 显示到界面上的状态
    struct State {
        var items: [TNNews] = []
        var isloading = false
    }
    
    // 初始化的状态
    let initialState: State
    init() {
        self.initialState = State()
    }
    
    // Action -> Mutation 将用户行为转换为显示状态，并返回 Mutation 可观察序列
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh(let type):
            return Observable.concat([
                Observable.just(Mutation.isloading(true)),
                GankNewsViewModel.shared.getCategory(to: type).concatMap({ (models) -> Observable<Mutation> in
                    return Observable.just(Mutation.loadFirstData(models))
                }),
                Observable.just(Mutation.isloading(false))
            ])
        case .loadMore(let type):
            return Observable.concat([
                Observable.just(Mutation.isloading(true)),
                GankNewsViewModel.shared.loadMore(to: type).concatMap({ (models) -> Observable<Mutation> in
                    return Observable.just(Mutation.loadMoreData(models))
                }),
                Observable.just(Mutation.isloading(false))
            ])
        }
    }
    
    // Mutation -> State 拿到方法1中的 Mutation ，更新状态
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .loadFirstData(let models):
            state.items = models
        case .isloading(let f):
            state.isloading = f
        case .loadMoreData(let models):
            state.items += models
        }
        return state
    }
    
}
