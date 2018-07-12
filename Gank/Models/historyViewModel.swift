//
//  historyViewModel.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/2.
//

import Foundation
import RxCocoa
import RxSwift

final class historyViewModel {
    
    let tableData = BehaviorRelay<[String]>(value: [])
    init(dispose: DisposeBag) {
        Service.shared.historyDate()
            .bind(to: tableData)
            .disposed(by: dispose)
        
    }
}
