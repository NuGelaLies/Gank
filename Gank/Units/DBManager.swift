//
//  DatabaseManager.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/29.
//

import Foundation
import WCDBSwift

class Simple: WCDBSwift.TableCodable {
    //Your own properties
    let variable1: Int = 0
    var variable2: String? // Optional if it would be nil in some WCDB selection
    var variable3: Double? // Optional if it would be nil in some WCDB selection
    let unbound: Date? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Simple
        
        //List the properties which should be bound to table
        case variable1 = "custom_name"
        case variable2
        case variable3
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        //Column constraints for primary key, unique, not null, default value and so on. It is optional.
        //static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
        //    return [
        //        .variable: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
        //        .variable2: ColumnConstraintBinding(isUnique: true)
        //    ]
        //}
        
        //Index bindings. It is optional.
        //static var indexBindings: [IndexBinding.Subfix: IndexBinding]? {
        //    return [
        //        "_index": IndexBinding(indexesBy: CodingKeys.variable2)
        //    ]
        //}
        
        //Table constraints for multi-primary, multi-unique and so on. It is optional.
        //static var tableConstraintBindings: [TableConstraintBinding.Name: TableConstraintBinding]? {
        //    return [
        //        "MultiPrimaryConstraint": MultiPrimaryBinding(indexesBy: variable2.asIndex(orderBy: .descending), variable3.primaryKeyPart2)
        //    ]
        //}
        
        //Virtual table binding for FTS and so on. It is optional.
        //static var virtualTableBinding: VirtualTableBinding? {
        //    return VirtualTableBinding(with: .fts3, and: ModuleArgument(with: .WCDB))
        //}
    }
    
    //Properties below are needed only the primary key is auto-incremental
    //var isAutoIncrement: Bool = false
    //var lastInsertedRowID: Int64 = 0
}


final class DBManager {
    
    static let shared = DBManager()
    
    private let db: Database
    
    init() {
       
       self.db = self.creatDB(name: "sample")
    }
    
    /** 创建数据库*/
    private func creatDB(name: String) -> Database {
        let doucumentPaths = NSHomeDirectory() + "\(name).db"
        return Database(withPath: doucumentPaths)
    }
    
//    /** 建表*/
//    public func creatTB<T: WCDBSwift.TableCodable>(_ :T.Type) {
//        do {
//            try db.create(table: String(describing: T.self), of: T.self)
//        } catch let error {
//            log.error(error)
//        }
//    }
//    /** 插入*/
//    public func insert(_ object: WCDBSwift.TableCodable) {
//        do {
//            try db.insert(objects: object, intoTable: String(describing: object.self))
//        } catch let error {
//            log.error(error)
//        }
//    }
//
//    /** 更新*/
//    public func update(_ object: WCDBSwift.TableCodable) {
//        do {
//            try db.update(table: String(describing: object.self), on: object.Properties.all, with: object)
//        } catch let error {
//            log.error(error)
//        }
//    }
}
