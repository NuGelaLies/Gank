//
//  GNNews.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/7.
//

import UIKit

struct TNNews: Codable {
    var _id : String?
    var desc: String?
    var createdAt: String?
    var images: [URL]?
    var publishedAt: String?
    var source: String?
    var url: String?
    var used: Bool?
    var who: String?
}

struct Relaxs: Codable {
    var _id: String?
    var en_name: String?
    var name: String?
    var rank: Int?
}
