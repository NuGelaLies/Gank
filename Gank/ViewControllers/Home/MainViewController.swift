//
//  MainViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/7.
//

import UIKit
import RxSwift
import RxDataSources

class MainViewController: BaseViewController {
    let disposeBag = DisposeBag()
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, TNNews>>?
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: .zero, style: .grouped)
        tv.estimatedRowHeight = 300
        tv.separatorStyle = .none
        tv.estimatedSectionFooterHeight = 0
        tv.estimatedSectionHeaderHeight = 0
        tv.rowHeight = UITableViewAutomaticDimension
        tv.backgroundColor = UIColor.colorWith(r: 240, g: 240, b: 240)
        tv.register(HomeVeiwCell.self)
        tv.register(headerFooterViewClass: HomeHeaderFooterView.self)
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "干货集中营"
        
        
    }
    
    override func setupSubViews() {
       
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
 
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueHeaderFooter(HomeHeaderFooterView.self)
        if let t = dataSource?.sectionModels[section].model {
           header.configTitle(t)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
}

