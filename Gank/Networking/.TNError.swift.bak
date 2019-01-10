//
//  TNError.swift
//  todayNews
//
//  Created by NuGelaLiee on 2018/2/10.
//  Copyright © 2018年 RxGank. All rights reserved.
//

import UIKit
import RxSwift

enum TNError: Swift.Error {
    case parseJSONError
    case noRepresentor
    case notSuccessfulHTTP
    case noData
    case couldNotMakeObjectError
    case bizError(resultCode: Int?, resultMsg: String?)
}

enum BizStatus: String {
    case success = "success"
    case error
}

extension TNError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parseJSONError:
            return "数据解析失败"
        case .noRepresentor:
            return "NoRepresentor."
        case .notSuccessfulHTTP:
            return "NotSuccessfulHTTP."
        case .noData:
            return "NoData."
        case .couldNotMakeObjectError:
            return "CouldNotMakeObjectError."
        case .bizError(resultCode: let resultCode, resultMsg: let resultMsg):
            return "错误码: \(resultCode ?? 0), 错误信息: \(resultMsg ?? "")"
        }
    }
}

extension Observable {
    func showErrorToToast() -> Observable<Element> {
        return catchError({ info -> Observable<Element> in
            // toast
            HUD.dismiss()
            if let error = info as? TNError {
                switch error {
                case .parseJSONError , .noRepresentor, .notSuccessfulHTTP, .noData, .couldNotMakeObjectError:
                    HUD.showError(error.errorDescription ?? "")
                case .bizError(resultCode: _, resultMsg: let message):
                    log.error(message ?? "nil error")
                }
            } else {
                log.error(info.localizedDescription)
            }
            
            return Observable.empty()
        })
    }
}
