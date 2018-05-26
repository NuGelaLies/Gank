//
//  NetworkService.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/5/26.
//

import Foundation
import RxSwift
import RxDataSources

final class NetworkService {
    var page = 1
    
    func getCategory(to type: GNCategory) -> Observable<[TNNews]> {
        page = 1
        return Api.analysis(.get(type, page))
                    .mapModelArray(TNNews.self).share(replay: 1)
    }

    // nugela
    func loadMore(to type: GNCategory) -> Observable<[TNNews]> {
        return Api.analysis(.get(type, page))
            .mapModelArray(TNNews.self)
            .doOnNext({ [weak self] (models) in
                guard let `self` = self else {return}
                if models.count > 0 {
                    self.page += 1
                }
            }).share(replay: 1)
    }
    
    private let historySignal = Api.analysis(.getHistory())
        .analysisJSON()
        .map{($0.arrayValue.first?.string ?? "").replacingOccurrences(of: "-", with: "/")}
    
    func loadAnasisData(to date: String) -> Observable<[TNNews]> {
        return Api.analysis(.getDateNews(date)).mapModelArray(TNNews.self)
    }
    
    func leastNew() -> Observable<[TNNews]> {
        return historySignal.flatMapLatest({ (date) in
            return Api.analysis(.getDateNews(date)).mapModelArray(TNNews.self).share(replay: 1)
        })
    }
    
    func loadContentDate() -> Observable<[TNNews]> {
        return Api.analysis(.getWitchDateNews(2)).mapModelArray(TNNews.self).share(replay: 1)
    }
    
    func loadDatilyNews() -> Observable<[SectionModel<String, TNNews>]> {
        return historySignal.flatMapLatest({ (date)  in
            return Api.analysis(.getCategoryNew(date)).analysisJSON()
                .map({ (obj) in
                    let j = obj.dictionaryObject! as NSDictionary
                    let keys = j.allKeys as! [String]
                    var leasts: [[TNNews]] = []
                    for (_ , jsons) in j {
                        guard let data = try? JSONSerialization.data(withJSONObject: jsons, options: []),
                            let news = try? JSONDecoder().decode([TNNews].self, from: data)
                            else {return []}
                        leasts.append(news)
                    }
                    return zip(keys, leasts).compactMap {SectionModel.init(model: $0, items: $1)}
                }).share(replay: 1)
        })
    }
    
}
