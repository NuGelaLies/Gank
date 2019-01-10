//
//  Date+Extension.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/15.
//

import Foundation

extension Date {
    /// yyyy
    var year: String? {
        return dateForm(form: "yyyy")
    }
    /// MM
    var month: String? {
        return dateForm(form: "MM")
    }
    /// dd
    var day: String? {
        return dateForm(form: "dd")
    }
    /// mm:ss
    var time: String? {
        return dateForm(form: "mm:ss")
    }
    /// yyyy/MM/dd
    var detailTime: String? {
        return dateForm(form: "yyyy/MM/dd")
    }
    
    func dateForm(form: String) -> String? {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = form
        return dfmatter.string(from: self)
    }
}

extension String {
    
    func dateForm(form: String) -> Date? {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = form
        return dfmatter.date(from: self)
    }
    
    func toTime(dateFrom: String,  dateTo: String) -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = dateTo
        guard let date = dateForm(form: dateFrom) else { return ""}
        return dfmatter.string(from: date)
    }
    
    func toTime() -> String {
        return toTime(dateFrom: "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'", dateTo: "yyyy/MM/dd")
    }
    
}

extension String {
    func toMonth() -> String {
        guard let num = self.ints else {return ""}
        switch num {
        case 1:
            return "一月"
        case 2:
            return "二月"
        case 3:
            return "三月"
        case 4:
            return "四月"
        case 5:
            return "五月"
        case 6:
            return "六月"
        case 7:
            return "七月"
        case 8:
            return "八月"
        case 9:
            return "九月"
        case 10:
            return "十月"
        case 11:
            return "十一月"
        case 12:
            return "十二月"
        default:
            return ""
        }
    }
}
