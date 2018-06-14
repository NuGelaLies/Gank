//
//  HomeVeiwCell.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/7.
//

import UIKit
import RxCocoa
import RxSwift

class HomeVeiwCell: UITableViewCell {
   
    lazy var contentLabel: UILabel = {
        let b = UILabel()
        b.font = UIFont.boldSystemFont(ofSize: 16)
        b.textColor = UIColor.hex(0x353535)
        b.numberOfLines = 0
        return b
    }()
    
    lazy var dateLabel: UILabel = {
        let b = UILabel()
        b.textColor = .black
        b.font = UIFont.boldSystemFont(ofSize: 13)
        b.textColor = UIColor.hex(0x888888)
        b.numberOfLines = 0
        return b
    }()
    
    lazy var authorLabel: UILabel = {
        let b = UILabel()
        b.textColor = .black
        b.font = UIFont.boldSystemFont(ofSize: 13)
        b.textColor = UIColor.hex(0x888888)
        b.numberOfLines = 0
        return b
    }()
    
    lazy var poi: UIImageView = {
        let img = UIImageView()
        img.image = UIImage.init(named: "dot")
        img.contentMode = .scaleToFill
        return img
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model: TNNews? {
        didSet {
           
            self.dateLabel.text = self.model?.publishedAt
            self.contentLabel.text = self.model?.desc
            self.authorLabel.text = "via. \(self.model?.who ?? "机器人")"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {

        contentView.addSubview(poi)
        poi.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(15)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else {return}
            make.left.equalTo(self.poi.snp.right).offset(10)
            make.right.lessThanOrEqualToSuperview().offset(-30)
            make.centerY.equalTo(self.poi)
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else {return}
            make.left.equalTo(30)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(5)
            make.right.lessThanOrEqualToSuperview().offset(-30)
        }
        
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else {return}
            make.left.equalTo(self.contentLabel)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(5)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        
        let line = UIView().then { (make) in
            make.backgroundColor = UIColor.colorWith(r: 240, g: 240, b: 240)
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints { [weak self] (make) in
            guard let `self` = self else {return}
            make.left.equalTo(self.authorLabel)
            make.height.equalTo(1)
            make.right.bottom.equalToSuperview()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
