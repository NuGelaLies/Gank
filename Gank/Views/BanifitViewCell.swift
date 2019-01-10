//
//  BanifitViewCell.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/15.
//

import UIKit
import SDWebImage

class BanifitViewCell: UICollectionViewCell {

    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var banifitVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        common()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func common() {
        self.clipsToBounds = false
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 6)
        
        self.banifitVIew.contentMode = .scaleToFill

    }
    
    var model: TNNews? {
        didSet {
            guard let model = self.model else { return }
            
            if let publishedAt = model.publishedAt {
                self.publishDate.text = publishedAt.toTime()
            } else {
                self.publishDate.text = ""
            }
            self.author.text = "via. \(model.who ?? "Mr.R")"
            
            if let url = model.url {
                banifitVIew?.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "meizi_loading"), options: .refreshCached)
            }
            
            
        }
    }
}
