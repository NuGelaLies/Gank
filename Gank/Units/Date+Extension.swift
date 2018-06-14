//
//  Date+Extension.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/15.
//

import Foundation

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
        return toTime(dateFrom: "yyyy-MM-dd HH:mm:ss.SSS", dateTo: "yyyy EEE mm")
    }
    
}
