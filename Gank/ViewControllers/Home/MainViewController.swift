//
//  MainViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/7.
//

import UIKit
import RxSwift
import RxDataSources
import ReactorKit

class MainViewController: BaseViewController, View {
    var disposeBag = DisposeBag()
    
    typealias Reactor = MainCategoryReactor
    
    lazy var article = GankNewsViewModel()
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
    
    func bind(reactor: MainCategoryReactor) {
        
        dataSource = RxTableViewSectionedReloadDataSource(configureCell: { (_, tv, index, item) in
            let cell = tv.dequeue(HomeVeiwCell.self)
            cell.model = item
            cell.selectionStyle = .none
            return cell
        })
        
        rx.viewDidLoad.map {Reactor.Action.setDatilyData}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map {$0.items}
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TNNews.self)
            .subscribeNext { [weak self] (model) in
                guard let `self` = self else {return}
                let web = BaseWebViewController()
                web.url = model.url ?? Constant.web.defaultWebSite
                self.navigationController?.pushViewController(web, animated: true)
            }.disposed(by: disposeBag)
    }
    
    //MARK: 子视图处理
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

