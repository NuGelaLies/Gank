//
//  GNDataBase.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/30.
//

import Foundation
import WCDBSwift

enum GNDataBase: String {
    
    fileprivate static let documentPath = NSSearchPathForDirectoriesInDomains(
        FileManager.SearchPathDirectory.documentDirectory,
        FileManager.SearchPathDomainMask.userDomainMask, true).first!
    
    case account = "account.db"
    
    case notification = "notification.db"
    
}

extension GNDataBase: DataBaseProtocol {
    var path: String {
        return GNDataBase.documentPath + "/" + self.rawValue
    }
    
    var tag: Int {
        switch self {
        case .account:
            return 1
        case .notification:
            return 2
        }
    }
    var db: Database {
        let dataBase = Database(withPath: self.path)
        dataBase.tag = self.tag
        return dataBase
    }
}


// MARK:表名
enum GNTableName: String {
    
    case account = "account"
    
    case notification = "notification"
    
}

extension GNTableName: TableNameProtocol {
    /// 表对应的数据库
    var database: Database {
        switch self {
        case .account:
            return GNDataBase.account.db
        case .notification:
            return GNDataBase.notification.db
        }
    }
    
    /// 查询 提前定义
    var selectTable: Select? {
        var pre_select: Select?
        switch self {
        case .account:
            pre_select = try? database.prepareSelect(of: User.self, fromTable: tableName, isDistinct: true)
        case .notification:
            pre_select = try? database.prepareSelect(of: message.self, fromTable: tableName, isDistinct: true)
        }
        return pre_select
    }

    /// 表的名称
    var tableName: String{
        return self.rawValue
    }
}
