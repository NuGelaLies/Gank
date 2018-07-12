//
//  Tools+Rx.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/10.
//

import RxSwift
import RxCocoa

public extension ObservableType {
    
    func then(_ closure: @escaping @autoclosure () throws -> Void) -> Observable<E> {
        return map {
            try closure()
            return $0
        }
    }
    
    func map<T>(to transform: @escaping @autoclosure () throws -> T) -> Observable<T> {
        return map { _ in try transform() }
    }
    
    func flatMap<T>(to transform: @escaping @autoclosure () throws -> Observable<T>) -> Observable<T> {
        return flatMap { _ in try transform() }
    }
    
    func filter(_ predicate: @escaping @autoclosure () throws -> Bool) -> Observable<E> {
        return filter { _ in try predicate() }
    }
    
    func catchErrorJustReturn(closure: @escaping @autoclosure () throws -> E) -> Observable<E> {
        return catchError { _ in
            return Observable.just(try closure())
        }
    }
    
    func shareOnce() -> Observable<E> {
        return share(replay: 1)
    }
    
    func onMainScheduler() -> Observable<E> {
        return observeOn(MainScheduler.instance)
    }

}

public extension Driver {
    
    func then(_ closure: @escaping @autoclosure () -> Void) -> SharedSequence<S, E> {
        return map {
            closure()
            return $0
        }
    }
    
    func map<T>(to transform: @escaping @autoclosure () -> T) -> SharedSequence<S, T> {
        return map { _ in transform() }
    }
    
    func flatMap<T>(to transform: @escaping @autoclosure () -> SharedSequence<S, T>) -> SharedSequence<S, T> {
        return flatMap { _ in transform() }
    }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait {
    
    func filter(_ predicate: @escaping @autoclosure () throws -> Bool) -> Maybe<ElementType> {
        return filter { _ in try predicate() }
    }
}

public extension PrimitiveSequenceType where TraitType == SingleTrait {
    
    func filter(_ predicate: @escaping @autoclosure () throws -> Bool) -> Maybe<ElementType> {
        return filter { _ in try predicate() }
    }
}

public extension ObservableConvertibleType {
    
    func asDriver(onErrorJustReturnClosure: @escaping @autoclosure () -> E) -> Driver<E> {
        return asDriver { _ in
            Driver.just(onErrorJustReturnClosure())
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            Driver.empty()
        }
    }
}



