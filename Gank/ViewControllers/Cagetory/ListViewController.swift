//
//  ListViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/15.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

class ListViewController: UBaseViewController {

    var categoryBelay: GNCategory!
    let items = BehaviorRelay<[TNNews]>(value: [])
    var viewModel: GNCategoryViewModel!
    
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 300
        tv.rowHeight = UITableViewAutomaticDimension
        tv.backgroundColor = UIColor.colorWith(r: 240, g: 240, b: 240)
        tv.mj_header = MJRefreshStateHeader()
        tv.mj_footer = MJRefreshAutoStateFooter()
        tv.register(HomeVeiwCell.self)
        return tv
    }()
    
    
    convenience init(category: GNCategory) {
        self.init(nibName: nil, bundle: nil)
        self.categoryBelay = category
        self.viewModel = GNCategoryViewModel(category: category)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.mj_header.beginRefreshing()
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
    
    override func setupRxConfig() {
        tableView.rx.modelSelected(TNNews.self)
            .subscribeNext { [weak self] (item) in
                guard let `self` = self else {return}
                let web = BaseWebViewController()
                web.url = item.url ?? Constant.web.defaultWebSite
                self.navigationController?.pushViewController(web, animated: true)
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected
            .bind(to: tableView.rx.deSelectRow())
            .disposed(by: rx.disposeBag)
    }
    
    override func bindViewModels() {
        
        let inputs = viewModel.inputs
        let outputs = viewModel.outputs
        
        tableView.mj_header.rx.refreshing
            .bind(to: inputs.headerRefresh)
            .disposed(by: rx.disposeBag)
        
        tableView.mj_footer.rx.refreshing
            .bind(to: inputs.footerRefresh)
            .disposed(by: rx.disposeBag)
        
        outputs.endHeaderRefresh
            .bind(to: tableView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        outputs.endFooterRefresh
            .bind(to: tableView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
        
        outputs.tableData
            .bind(to: tableView.rx.items(cellIdentifier: "HomeVeiwCell", cellType: HomeVeiwCell.self)) {
                row, model, cell in
                cell.model = model
            }.disposed(by: rx.disposeBag)
        
    }
    
   
}
