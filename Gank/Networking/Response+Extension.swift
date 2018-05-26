//
//  Response+Extension.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/24.
//

import Foundation
import Moya
import SwiftyJSON
import RxSwift

//MARK: HandyJSON + Extension
extension Response {
//    
//    func mapModel<T: HandyJSON>(_ type: T.Type) -> T? {
//        if let jsonString = toDictionary() {
//            return T.deserialize(from: jsonString)
//        }
//        return nil
//    }
//    
//    func mapModelArray<T: HandyJSON>(_ type: T.Type) -> [T]? {
//        if let dataArr = toAnyArray() {
//            return [T].deserialize(from: dataArr) as? [T]
//        }
//        return nil
//    }
}

//MARK: mapJSON
extension Response {
    func toDictionary(for path: String? = nil) -> [String: Any]? {
        return toJSON(for: path).dictionaryObject
    }
    
    func toAnyArray(for path: String? = nil) -> [Any]? {
        return toJSON(for: path).arrayObject
    }
    
    func toJSON(for path: String? = nil) -> JSON {
        guard let path = path else {
            return JSON(data)[results]
        }
        return JSON(data)[results][path]
    }
}

//MARK: Codable + Extension
extension Response {
    
    func mapModel<T: Codable>(_ type: T.Type, for path: String? = nil, using decoder: JSONDecoder = .init()) throws -> T  {
        guard let item = toDictionary(for: path)  else {
            throw TNError.couldNotMakeObjectError
        }
        do {
            guard let data = try? JSONSerialization.data(withJSONObject: item, options: []) else {
                throw TNError.noData
            }
            return try decoder.decode(T.self, from: data)
        } catch let error {
            throw error
        }
    }
    
    func mapModelArray<T: Codable>(_ type: T.Type, for path: String? = nil , using decoder: JSONDecoder = .init()) throws -> [T] {
        guard let items = toAnyArray(for: path) else {
            throw TNError.couldNotMakeObjectError
        }
        do {
            guard let data = try? JSONSerialization.data(withJSONObject: items, options: []) else {
                throw TNError.noData
            }
            return try decoder.decode([T].self, from: data)
        } catch let error {
            throw error
        }
    }
}



extension Dictionary {
//    func mapModel<T: HandyJSON>(_ type: T.Type) -> T? {
//        guard let model = T.deserialize(from: self as? [String: Any]) else {
//            return nil
//        }
//        return model
//    }
    
}

extension Array {
//    func mapModelArray<T: HandyJSON>(_ type: T.Type) -> [T]? {
//        guard let models = [T].deserialize(from: self) as? [T] else {
//            return nil
//        }
//        return models
//    }
}


extension String {
//    func mapModel<T: HandyJSON>(_ type: T.Type) -> T? {
//        guard let model = T.deserialize(from: self) else {
//            return nil
//        }
//        return model
//    }
//    
//    func mapModelArray<T: HandyJSON>(_ type: T.Type) -> [T]? {
//        guard let models = [T].deserialize(from: self) as? [T] else {
//            return nil
//        }
//        return models
//    }
}

