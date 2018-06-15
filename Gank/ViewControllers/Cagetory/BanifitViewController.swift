//
//  BanifitViewController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/6/15.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class BanifitViewController: BaseViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryBelay: GNCategory!
    var viewModel: GankCategoryViewModel!
    
    //let items = BehaviorRelay<[TNNews]>(value: [])
    
    init(category: GNCategory) {
        super.init(nibName: nil, bundle: nil)
        self.categoryBelay = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func setupSubViews() {
        collectionView.registerNib(BanifitViewCell.self)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.mj_header = MJRefreshStateHeader()
        collectionView.mj_footer = MJRefreshAutoStateFooter()
        
        viewModel = GankCategoryViewModel(
            input: (headerRefresh: self.collectionView.mj_header.rx.refreshing.asDriver(),
                    footerRefresh: self.collectionView.mj_footer.rx.refreshing.asDriver(),
                    category: self.categoryBelay),
            disposeBag: self.disposeBag)
    }
    
    override func setupRxConfig() {
        collectionView.rx.modelSelected(TNNews.self)
            .subscribeNext { (model) in
                let web = BaseWebViewController()
                web.url = model.url ?? Constant.web.defaultWebSite
                self.navigationController?.pushViewController(web, animated: true)
            }.disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        viewModel.tableData.asDriver()
            .drive(collectionView.rx.items(cellIdentifier: "BanifitViewCell", cellType: BanifitViewCell.self)) {
                row, model, cell in
                cell.model = model
            }.disposed(by: disposeBag)
        
        viewModel.headerRefreshing.asDriver()
            .drive(collectionView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.footerRefreshing.asDriver()
            .drive(collectionView.mj_footer.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        
    }
}

extension BanifitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((Constant.UI.kScreenW - 15) / 2)
        let height = Constant.UI.kScreenH / 3
        return CGSize(width: width, height: height)
        
    }
}
