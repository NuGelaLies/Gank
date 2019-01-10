//
//  MainViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/7.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MJRefresh

class MainViewController: UBaseViewController {
    let Bag = DisposeBag()
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, TNNews>>?
    lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: .zero, style: .plain)
        tv.estimatedRowHeight = 300
        tv.separatorStyle = .none
        tv.estimatedSectionFooterHeight = 0
        tv.estimatedSectionHeaderHeight = 0
        tv.rowHeight = UITableViewAutomaticDimension
        tv.backgroundColor = UIColor.colorWith(r: 240, g: 240, b: 240)
        tv.register(HomeVeiwCell.self)
        tv.registerNib(ShimmerCell.self)
        tv.mj_header = MJRefreshNormalHeader()
        tv.register(headerFooterViewClass: HomeHeaderFooterView.self)
        return tv
    }()
    
    lazy var gankHeaderView: BanifitHeaderView = {
        let benifit = UINib.viewFromNib(BanifitHeaderView.self)
        benifit.frame = CGRect(x: 0, y: 0, width: Constant.UI.kScreenW, height: 235)
        return benifit
    }()
    
    var viewModel: GankNewsViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "干货集中营"

    }
    override func setupSubViews() {
       
        viewModel = GankNewsViewModel(
            input:(headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(),
                   disposeBag: Bag))
        view.addSubview(tableView)
        
        tableView.rx.setDelegate(self).disposed(by: Bag)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        let calenderItem = UIBarButtonItem(image: UIImage(named: "calendar"), style: .plain) {
            [weak self] in
            let Calendar = CalenderController()
            Calendar.title = "历史的年轮"
            Calendar.delegate = self
            self?.navigationController?.pushViewController(Calendar, animated: true)
        }
        calenderItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = calenderItem
    }
    
    override func setupRxConfig() {
        dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, TNNews>>(configureCell: { (ds, tv, indexPath, element) -> UITableViewCell in
            let cell = tv.dequeue(HomeVeiwCell.self)
            cell.model = element
            return cell
        })
        
        tableView.rx.modelSelected(TNNews.self)
            .map {
                let web = BaseWebViewController()
                web.url = $0.url ?? Constant.web.defaultWebSite
                return web
            }
            .bind(to: rx.push).disposed(by: Bag)
        
        tableView.rx.itemSelected
            .bind(to: tableView.rx.deSelectRow())
            .disposed(by: Bag)
        
        viewModel.tableData.asDriver(onErrorJustReturn: [])
            .map {$0.filter {$0.model != GNCategory.Banifit.rawValue}}
            .drive(tableView.rx.items(dataSource: dataSource!))
            .disposed(by: Bag)
        
        viewModel.tableData.asDriver(onErrorJustReturn: [])
            .map {$0.filter {$0.model == GNCategory.Banifit.rawValue}}
            .map {$0.first?.items.first}
            .driveNext { (item) in
                guard let item = item else {return}
                let height = self.gankHeaderView.configModel(to: item)
                self.gankHeaderView.frame.size.height = height
                self.tableView.tableHeaderView = self.gankHeaderView
            }.disposed(by: Bag)

        viewModel.refreshing
            .drive(tableView.mj_header.rx.endRefreshing)
            .disposed(by: Bag)
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

extension Reactive where Base == MainViewController  {
    var push: Binder<UBaseViewController> {
        return Binder(base) { vc, type in
            vc.navigationController?.pushViewController(type, animated: true)
        }
    }
}

extension MainViewController: CalenderControllerDelegate {
    
    func selectCalender(to date: String) {
//        viewModel.getNews(to: date)
//            .bind(to: <#T##BehaviorRelay<[GankNewsSection]>#>)
//            .disposed(by: Bag)
    }
}

