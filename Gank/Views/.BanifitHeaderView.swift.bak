//
//  BanifitHeaderView.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/12.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class BanifitHeaderView: UIView {
    
    @IBOutlet weak var banifitImageView: UIImageView!
    
    @IBOutlet weak var day: UILabel!
    
    @IBOutlet weak var month: UILabel!
    
    func configModel(to model: TNNews) -> CGFloat {
        var height: CGFloat = 235
        guard let imageURL = model.url else {
            return height
        }
        guard let url = URL(string: imageURL) else {
            return height
        }
        guard let imageData = try? Data(contentsOf: url) else {
            return height
        }
        
        guard let img = UIImage(data: imageData) else {
            return height
        }
        
        banifitImageView.image = img
        
        day.text = model.publishedAt?.toTime().dateForm(form: "yyyy-MM-dd")?.day
        month.text = model.publishedAt?.toTime().dateForm(form: "yyyy-MM-dd")?.month?.toMonth()
        height = Constant.UI.kScreenW / img.size.width * img.size.height
        return height + 35
    }
}
