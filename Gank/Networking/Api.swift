//
//  TNApi.swift
//  todayNews
//
//  Created by NuGelaLiee on 2018/2/10.
//  Copyright © 2018年 RxGank. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import Moya
import Alamofire


let SUCCESSCODE = "code"
let MESSAGE = "message"
let DATA = "data"

let results = "results"

final class Api: MoyaProvider<ApiConfig> {
    
    static let shared = Api()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = 15
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        super.init(manager: manager)
    }
    
    class func analysis(_ target: ApiConfig,
                        callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        HUD.show()
        return Observable<Response>.create({ (observer) -> Disposable in
            let cancelTask = Api.shared.request(target, callbackQueue: callbackQueue, progress: nil, completion: { (results) in
                HUD.dismiss()
                switch results {
                case .success(let obj):
                    guard ((200...209) ~= obj.statusCode) else {
                        observer.onError(TNError.notSuccessfulHTTP)
                        return
                    }
                    guard let _ = JSON(obj.data).dictionaryObject else {
                        observer.onError(TNError.noData)
                        return
                    }
                        observer.onNext(obj)
                        observer.onCompleted()
                    #if DEBUG
                        log.debug(obj.messageLog)
                    #endif
                case .failure(let error):
                    #if DEBUG
                        log.error(error)
                    #endif
                    observer.onError(error)
                }
            })
            return Disposables.create {
                cancelTask.cancel()
            }
            
        })
    }
}

extension Response: CustomStringConvertible {
    var messageLog: String {
        func analysis(data: Data?) -> String? {
            guard let dat = data else { return "" }
            return String(data: dat, encoding: .utf8)
        }
        
        let start = "\n==============>>> HTTP Message Start <<<==============\n"
        let path = request?.url?.absoluteString
        let requestJson = analysis(data: request?.httpBody)
        let responseJson = analysis(data: data)
        let ended = "\n==============>>> HTTP Message Ended <<<==============\n"
        let components = [start, path, requestJson, path, responseJson, ended]
        return components.flatMap { $0 }.joined(separator: "\n")
    }
}
