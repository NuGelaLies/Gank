//
//  GNDBManager+Rx.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/30.
//

import Foundation
import WCDBSwift
import RxSwift
import RxCocoa

extension Reactive where Base: GNDBManager {
    
    func loadUser() -> Observable<[User]> {
        return Observable<[User]>.create({ (observer) -> Disposable in
           // GNDBManager.select(GNTableName.account, conditioin: nil, errorClosure: nil)
            return Disposables.create()
        })
    }
    
    //新增
    func addUser(_ account: User) -> Observable<Bool> {
        return Observable<Bool>.create({ (observer) -> Disposable in
            GNDBManager.insert(GNTableName.account, objects: [account], errorClosure: { (error) in
                guard let err = error else {
                    observer.onNext(false)
                    observer.onCompleted()
                    return
                }
                log.error(err)
                observer.onError(err)
            }) {
                observer.onNext(true)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    //删除
    func deleteUser(_ account: User) -> Observable<Bool> {
        return Observable<Bool>.create({ (observer) -> Disposable in
            GNDBManager.delete(GNTableName.account, conditioin: User.Properties.name == account.name, errorClosure: { (error) in
                if error != nil {
                    log.error(error!)
                    observer.onNext(false)
                } else {
                    observer.onNext(true)
                }
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    
}
