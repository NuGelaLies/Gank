//
//  Observable+Api.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/4/5.
//  Copyright © 2018年 NuGelaLiee. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import SwiftyJSON

//MARK: analysis String
extension ObservableType where E == String {
//    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
//        return flatMap { response -> Observable<T> in
//            if let json = response.mapModel(T.self) {
//                return Observable.just(json)
//            }
//            return Observable.empty()
//        }
//    }
//
//    public func mapModelArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
//        return flatMap { response -> Observable<[T]> in
//            if let json = response.mapModelArray(T.self) {
//                return Observable.just(json)
//            }
//            return Observable.empty()
//        }
//    }
}

extension ObservableType where E == [String: Any] {
//    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
//        return flatMap { response -> Observable<T> in
//            if let json = response.mapModel(T.self) {
//                return Observable.just(json)
//            }
//            return Observable.empty()
//        }
//    }
}

extension ObservableType where E == [Any] {
//    public func mapModelArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
//        return flatMap { response -> Observable<[T]> in
//            if let json = response.mapModelArray(T.self) {
//                return Observable.just(json)
//            }
//            return Observable.empty()
//        }
//    }
}

extension ObservableType where E == Response {
    //MARK: HandyJSON
//    func mapModel<T: HandyJSON>(_ type: T.Type, path: String? = nil) -> Observable<T> {
//        return flatMap { response -> Observable<T> in
//            guard let json = response.toDictionary(for: path) else {
//                return .empty()
//            }
//            guard let item = T.deserialize(from: json) else {
//                return .empty()
//            }
//            return Observable.just(item)
//        }
        //        return analysisJSON(for: path).map {
        //            return T.deserialize(from: $0.dictionaryObject)!
        //        }
//    }

//    func mapModelArray<T: HandyJSON>(_ type: T.Type, path: String? = nil) -> Observable<[T]> {
//        return flatMap { response -> Observable<[T]> in
//            guard let json = response.toAnyArray(for: path) else {
//                return .empty()
//            }
//            guard let items = [T].deserialize(from: json) as? [T] else {
//                return .empty()
//            }
//            return Observable.just(items)
//        }
        //        return analysisJSON(for: path).map {
        //            return T.deserialize(from: $0.arrayObject)!
        //        }
//    }
//
    //MARK: mapToJSON
    func analysisJSON(for path: String? = nil) -> Observable<JSON> {
        return flatMap({ (resonse) -> Observable<JSON> in
            let josn = resonse.toJSON(for: path)
            return Observable.just(josn)
        })
    }
    
    //MARK: Codable
    func mapModel<T: Codable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable<T>.create({ (observer) in
                do {
                    observer.onNext(try response.mapModel(T.self))
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
                return Disposables.create()
            })
        }
    }
    
    func mapModelArray<T: Codable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable<[T]>.create({ (observer) in
                do {
                    observer.onNext(try response.mapModelArray(T.self))
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
                return Disposables.create()
            })
        }
    }
}
