//
//  GNDBManager.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/30.
//

import Foundation
import WCDBSwift

class GNDBManager: NSObject {
    
    static let shared = GNDBManager()
    override init() {
        super.init();
        self.initializa();
    }
    /// 数据库表的初始化
    final func initializa(){
        debugPrint("数据库表的初始化");
        do {
            
            // 库创建表
            try GNDataBase.account.db.run(transaction: {
                try GNDataBase.account.db.create(table: GNTableName.account.tableName, of: User.self)
            })
            
            // 开启事务
            try GNDataBase.notification.db.run(transaction: {
                try GNDataBase.notification.db.create(table: GNTableName.notification.tableName, of: message.self)
            })
        } catch  {
            print("初始化数据库及ORM对应关系建立失败 \(error)")
        }
        
    }
    
}

extension GNDBManager: DBManagerProtocol {
    
    static func update<T>(_ table: TableNameProtocol, object: T, propertys: [PropertyConvertible], conditioin: Condition?, errorClosure: DBManagerProtocol.ErrorType?, successClosure: DBManagerProtocol.SuccessType?) where T: TableEncodable {
        DBManager.shared.update(table.database, tableName: table.tableName, object: object, propertys: propertys, conditioin: conditioin, errorClosure: errorClosure, successClosure: successClosure)
    }
    
    static func insert<T>(_ table: TableNameProtocol, objects: [T], errorClosure: DBManagerProtocol.ErrorType?, successClosure: DBManagerProtocol.SuccessType?) where T: TableEncodable {
        DBManager.shared.insert(table.database, tableName: table.tableName, objects: objects, errorClosurer: errorClosure, success: successClosure)
    }
    
    static func select<T>(_ table: TableNameProtocol, conditioin: Condition?, errorClosure: DBManagerProtocol.ErrorType?) -> [T]? where T: TableEncodable {
        return DBManager.shared.select(table.selectTable, conditioin: conditioin, errorClosure: errorClosure)
    }
    
    static func delete(_ table: TableNameProtocol, conditioin: Condition?, errorClosure: DBManagerProtocol.ErrorType?) {
        DBManager.shared.delete(table.database, tableName: table.tableName, condition: conditioin, errorClosure: errorClosure)
    }
    
    static func insertOrReplace<T>(_ table: TableNameProtocol, objects: [T], errorClosure: DBManagerProtocol.ErrorType?, successClosure: DBManagerProtocol.SuccessType?) where T: TableEncodable {
        DBManager.shared.insertOrReplace(table.database, tableName: table.tableName, objects: objects, errorClosure: errorClosure, successClosure: successClosure)
    }
    

    
}

