//
//  HomeHeaderFooterView.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/4/18.
//

import UIKit

class HomeHeaderFooterView: UITableViewHeaderFooterView {
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 20)
        l.numberOfLines = 1
        return l
    }()
    
    lazy var line: UIView = {
        let l = UIView()
        l.backgroundColor = UIColor.hex(0xF28B19)
        return l
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        backgroundColor = .white
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        contentView.addSubview(line)
        line.snp.makeConstraints { [unowned self] (make) in
            make.width.equalTo(30)
            make.height.equalTo(3)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
    }
    
    func configTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
}
