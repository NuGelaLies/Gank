//
//  Request.swift
//  todayNews
//
//  Created by NuGelaLiee on 2018/2/10.
//  Copyright © 2018年 RxGank. All rights reserved.
//

import Foundation
import Moya

enum GNCategory: String {
    case Android = "Android"
    case iOS = "iOS"
    case Banifit = "福利"
    case RelaxVideo = "休息视频"
    case ExtensionResource = "拓展资源"
    case WEB = "前端"
    case BlindCommend = "瞎推荐"
    case AllResouse = "all"
}

enum ApiConfig {
    /**所有干货，支持配图数据返回*/
    case get(GNCategory, Int)
    /**发过干货日期接口*/
    case getHistory()
    /**特定日期网站数据*/
    case getDateNews(String)
    /**每日数据*/
    case getCategoryNew(String)
    /**随机数据*/
    case getRandom(GNCategory, Int)
    /**获取某几日干货网站*/
    case getWitchDateNews(Int)
    /**搜索 API*/
    case getSearchCategory(GNCategory, Int)
    /**添加分类*/
   // case addGank(postGoods)
}

extension ApiConfig: TargetType {
    var baseURL: URL {
        return URL.init(string: "http://gank.io/api")!
    }
    
    var path: String {
        switch self {
        // 所有干货，支持配图数据返回
        case .get(let c, let i):
            return "data/\(c.rawValue)/\(Constant.Const.pageNum)/\(i)"
        // 发过干货日期接口
        case .getHistory():
            return "day/history"
        // 特定日期网站数据
        case .getDateNews(let s):
            return "history/content/day/\(s)"
        // 每日数据
        case .getCategoryNew(let s):
            return "day/\(s)"
        // 随机数据
        case .getRandom(let s, let p):
            return "random/data/\(s.rawValue)/\(Constant.Const.pageNum)/\(p)"
        // 获取某几日干货网站
        case .getWitchDateNews(let p):
            return "history/content/\(Constant.Const.pageNum)/\(p)"
        // 搜索 API
        case .getSearchCategory(let c, let p):
            return "search/query/listview/category/\(c.rawValue)/count/\(Constant.Const.pageNum)/page/\(p)"
//        case .addGank(_):
//            return "add2gank"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
         return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
