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

class ListViewController: BaseViewController {
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    var viewModel: GankCategoryViewModel!
    var categoryBelay: GNCategory!
    let items = BehaviorRelay<[TNNews]>(value: [])
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
    
    init(category: GNCategory) {
        super.init(nibName: nil, bundle: nil)
        self.categoryBelay = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        viewModel = GankCategoryViewModel(
            input: (headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(),
                    footerRefresh: self.tableView.mj_footer.rx.refreshing.asDriver(),
                    category: self.categoryBelay),
            disposeBag: self.disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupRxConfig() {
        tableView.rx.modelSelected(TNNews.self)
            .subscribeNext { (item) in
                let web = BaseWebViewController()
                web.url = item.url ?? Constant.web.defaultWebSite
                self.navigationController?.pushViewController(web, animated: true)
        }.disposed(by: disposeBag)
    }
    
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
                _, model, cell in
                cell.model = model
            }.disposed(by: disposeBag)
    }
}
