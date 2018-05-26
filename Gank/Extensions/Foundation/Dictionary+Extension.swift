//
//  Dictionary+Extension.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/31.
//

import Foundation

extension Dictionary {
    
    ///拼接请求字符串
    var urlParameterString: String {
        let query = map { "\($0)=\($1)" }.joined(separator: "&")
        return "?" + query
    }
}
