//
//  DatabaseManager.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/29.
//

import Foundation
import WCDBSwift


/// 协议扩展给业务层
protocol TableNameProtocol {
    /// 表名
    var tableName:String {get}
    
    /// 查找子表
    var selectTable:Select? {get}
    
    ///表对应的数据库
    var database:Database {get}
}

protocol DataBaseProtocol {
    ///数据库存放的路径
    var path:String {get}
    
    /// 数据库tag 对应唯一的数据库
    var tag:Int {get}
    
    /// 真实的数据库
    var db:Database {get}
}

protocol DBManagerProtocol {
    
    typealias ErrorType = (WCDBSwift.Error?)->Void
    typealias SuccessType = ()->Void
    
    /// 数据更新
    static func update<T: TableEncodable>(_ table: TableNameProtocol, object: T, propertys: [PropertyConvertible], conditioin: Condition?, errorClosure: ErrorType?, successClosure: SuccessType?)
    
    /// 数据插入
    static func insert<T: TableEncodable>(_ table: TableNameProtocol, objects: [T], errorClosure: ErrorType?, successClosure: SuccessType?)
    
    
    /// 数据查询
    static func select<T: TableEncodable>(_ table: TableNameProtocol, conditioin: Condition?, errorClosure: ErrorType?) -> [T]?
    
    /// 数据删除
    static func delete(_ table: TableNameProtocol, conditioin: Condition?, errorClosure: ErrorType?)
    
    /// 增量添加
    static func insertOrReplace<T: TableEncodable>(_ table: TableNameProtocol, objects: [T], errorClosure: ErrorType?, successClosure: SuccessType?)
    
    
}

/// 定义数据库的操作类
final class DBManager {

    static let shared = DBManager()
    typealias ErrorType = (WCDBSwift.Error?)->Void
    typealias SuccessType = ()->Void

    /// 数据插入
    func insert<T: TableEncodable>(_ dataBase:Database, tableName: String, objects:[T], errorClosurer: ErrorType? = nil, success: SuccessType? = nil) {
        do {
            try dataBase.insert(objects: objects, intoTable: tableName);
            success?();
        } catch  {
            let errorValue = error as? WCDBSwift.Error
            errorClosurer?(errorValue);
        }

    }


    /// 数据更新（条件）
    func update<T: TableEncodable>(_ dataBase: Database, tableName: String, object: T, propertys: [PropertyConvertible], conditioin: Condition? = nil, errorClosure: ErrorType? = nil, successClosure: SuccessType? = nil) {
        do {
            try dataBase.update(table: tableName, on: propertys, with: object, where: conditioin, orderBy: nil, limit: nil, offset: nil)
            successClosure?();

        } catch  {
            let errorValue = error as? WCDBSwift.Error
            errorClosure?(errorValue);
        }
    }


    /// 数据查询
    func select<T: TableEncodable>(_ select: Select?, conditioin: Condition? = nil, errorClosure: ErrorType? = nil) -> [T]?{
        do {
            if let conditioin = conditioin { //存在过滤条件 添加过滤条件
                select?.where(conditioin);
            }
            let objects:[T]? = try select?.allObjects() as?  [T];
            return objects;

        } catch  {
            let errorValue = error as? WCDBSwift.Error
            errorClosure?(errorValue);
        }
        return nil;
    }

    /// 数据删除
    func delete(_ dataBase: Database, tableName: String, condition: Condition? = nil, errorClosure: ErrorType? = nil)
    {
        do {
            try dataBase.delete(fromTable: tableName, where: condition, orderBy: nil, limit: nil, offset: nil)
        } catch {
            let errorValue = error as? WCDBSwift.Error
            errorClosure?(errorValue);
        }

    }


    /// 更新或插入
    func insertOrReplace<T: TableEncodable>(_ dataBase: Database, tableName: String, objects: [T], errorClosure: ErrorType? = nil, successClosure: SuccessType? = nil) {
        do {
            try dataBase.insertOrReplace(objects: objects, intoTable: tableName);
        } catch  {
            let errorValue = error as? WCDBSwift.Error
            errorClosure?(errorValue);
        }
    }
    
}
