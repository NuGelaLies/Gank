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

class BanifitViewController: UBaseViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryBelay: GNCategory!
    lazy var viewModel = GNCategoryViewModel(category: .Banifit)
    
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

       collectionView.mj_header.beginRefreshing()
    }
    
    override func setupSubViews() {
        collectionView.registerNib(BanifitViewCell.self)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.mj_header = MJRefreshStateHeader()
        collectionView.mj_footer = MJRefreshAutoStateFooter()
    }
    
    override func setupRxConfig() {
        collectionView.rx.modelSelected(TNNews.self)
            .subscribeNext { (model) in
                let web = BaseWebViewController()
                web.url = model.url ?? Constant.web.defaultWebSite
                self.navigationController?.pushViewController(web, animated: true)
            }.disposed(by: disposeBag)
    }
    
    override func bindViewModels() {
        let inputs = viewModel.inputs
        let outputs = viewModel.outputs
        
        collectionView.mj_header.rx.refreshing
            .bind(to: inputs.headerRefresh)
            .disposed(by: rx.disposeBag)
        
        collectionView.mj_footer.rx.refreshing
            .bind(to: inputs.footerRefresh)
            .disposed(by: rx.disposeBag)
        
        outputs.endHeaderRefresh
            .bind(to: collectionView.mj_header.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
            
        outputs.endFooterRefresh
            .bind(to: collectionView.mj_footer.rx.endRefreshing)
            .disposed(by: rx.disposeBag)
            
        outputs.tableData
            .bind(to: collectionView.rx.items(cellIdentifier: "BanifitViewCell", cellType: BanifitViewCell.self)) {
                row, model, cell in
                cell.model = model
            }.disposed(by: rx.disposeBag)
        
    }
}

extension BanifitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((Constant.UI.kScreenW - 15) / 2)
        let height = Constant.UI.kScreenH / 3
        return CGSize(width: width, height: height)
        
    }
}
