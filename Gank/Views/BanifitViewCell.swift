//
//  BanifitViewCell.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/15.
//

import UIKit
import Kingfisher

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
        self.banifitVIew.alpha = 0
        self.banifitVIew.image =  nil //Theme.UI.AppGreenBackagroundColor.toImage
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
            
            guard let url = model.url else { return }
            
            ImageDownloader.default.downloadImage(with: URL(string: url)!, options: [.fromMemoryCacheOrRefresh]) { [weak self] (image, error, _, data) in
                if error == nil {
                    guard let image = image else {return}
                    
                    let idata = UIImageJPEGRepresentation(image, 0.1)
                    
                    self?.banifitVIew.image = UIImage(data: idata!)
                    self?.banifitVIew.fadeIn()
                }
            }
            
        }
    }
}
