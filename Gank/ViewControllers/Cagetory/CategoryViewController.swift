//
//  CategoryViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/21.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import RxDataSources

class CategoryViewController: BaseViewController {
    let disposeBag = DisposeBag()
    
    var viewModel: GankCategoryViewModel!
    
    
    let segmentType = BehaviorRelay<GNCategory>(value: .Banifit)
    
    let items = BehaviorRelay<[TNNews]>(value: [])
    lazy var tableView: UITableView = {
        let tv = UITableView.init()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 300
        tv.rowHeight = UITableViewAutomaticDimension
        tv.backgroundColor = UIColor.colorWith(r: 240, g: 240, b: 240)
        tv.mj_header = MJRefreshStateHeader()
        tv.mj_footer = MJRefreshAutoStateFooter()
        tv.register(HomeVeiwCell.self)
        return tv
    }()
    
    override func bindViewModel() {
        viewModel.tableData.asDriver()
            .drive(items)
            .disposed(by: disposeBag)
        
        viewModel.headerRefreshing.asDriver()
            .drive(tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.footerRefreshing.asDriver()
            .drive(tableView.mj_footer.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        items.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "HomeVeiwCell", cellType: HomeVeiwCell.self)) {
                row, model, cell in
                cell.model = model
            }.disposed(by: disposeBag)

    }
    
    override func setupRxConfig() {
        
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
        
        viewModel = GankCategoryViewModel(
                            input: (headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(),
                                    footerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(),
                                    category: .Banifit),
                            dependency: (service: NetworkService(), disposeBag: self.disposeBag))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


