//
//  CategoryViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/21.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import MJRefresh
import RxDataSources

class CategoryViewController: BaseViewController, View {
    var disposeBag = DisposeBag()
    
    let categorySignal = Variable<GNCategory>(.AllResouse)
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, TNNews>>?
    
    let dataArr = BehaviorRelay<[TNNews]>(value: [])
    lazy var tableView: UITableView = {
        let tv = UITableView.init()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 300
        tv.rowHeight = UITableViewAutomaticDimension
        tv.backgroundColor = UIColor.colorWith(r: 240, g: 240, b: 240)
        tv.mj_header = MJRefreshStateHeader()
        tv.mj_footer = MJRefreshBackStateFooter()
        tv.register(HomeVeiwCell.self)
        return tv
    }()
    
    typealias Reactor = CategoryViewReactor
    
    func bind(reactor: CategoryViewReactor) {
 
        categorySignal.asDriver()
            .map {Reactor.Action.refresh($0)}
            .drive(reactor.action)
            .disposed(by: disposeBag)
        
        
        
        dataArr.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "HomeVeiwCell", cellType: HomeVeiwCell.self)) {
                row, model, cell in
                cell.model = model
            }.disposed(by: disposeBag)
        
        reactor.state.map {$0.items}
            .bind(to: dataArr)
            .disposed(by: disposeBag)
        
        reactor.state.map {$0.isloading}
            .bind(to: tableView.mj_header.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TNNews.self)
            .subscribeNext { (model) in
                let web = BaseWebViewController()
                web.url = model.url ?? Constant.web.defaultWebSite
                self.navigationController?.pushViewController(web, animated: true)
        }.disposed(by: disposeBag)
    }
    
    override func setupSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


