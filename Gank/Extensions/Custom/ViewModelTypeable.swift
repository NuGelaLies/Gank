//
//  ViewModelTypeable.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/25.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output

}
