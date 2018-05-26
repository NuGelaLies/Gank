//
//  MineViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class MineViewController: BaseViewController {
    
    let items = BehaviorRelay<[TNNews]>(value: [])
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self)
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 50
        tv.separatorStyle = .none
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupSubViews() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    override func bindViewModel() {

    }
    
    override func setupRxConfig() {
        Api.analysis(.get(.AllResouse, 1))
            .mapModelArray(TNNews.self)
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "UITableViewCell", cellType: UITableViewCell.self)) {
                _, element, cell in
                cell.textLabel?.text = element.desc
            }.disposed(by: rx.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
