//
//  MainCategoryReactor.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/4/18.
//

import Foundation
import ReactorKit
import RxSwift
import RxDataSources

class MainCategoryReactor: Reactor {
    
    enum Action {
        case setDatilyData
    }
    
    enum Mutation {
        case isLoading(Bool)
        case setDefaultData([SectionModel<String, TNNews>])
    }
    
    struct State {
        var items: [SectionModel<String, TNNews>] = []
        var isLoading = false
    }
    
    let initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setDatilyData:
            let load1 = Observable.just(Mutation.isLoading(true))
            let models1 = GankNewsViewModel.shared.loadDatilyNews().map{Mutation.setDefaultData($0)}
            let load2 = Observable.just(Mutation.isLoading(false))
            return .concat([load1, models1, load2])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var s = state
        switch mutation {
        case .isLoading(let f):
            s.isLoading = f
        case .setDefaultData(let items):
            s.items = items
        }
        return s
    }
}
