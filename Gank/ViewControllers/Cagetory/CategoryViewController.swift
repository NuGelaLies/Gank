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

class CategoryViewController: UBaseViewController {
    let disposeBag = DisposeBag()
    
    //var viewModel: GankCategoryViewModel!
    
    let items = BehaviorRelay<[GNCategory]>(value: [])
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var caregorys: [GNCategory] = [.AllResouse,
                                        .Android,
                                        .Banifit,
                                        .BlindCommend,
                                        .ExtensionResource,
                                        .iOS,
                                        .RelaxVideo,
                                        .WEB,
                                        .App]
    
    override func setupRxConfig() {
        
        items.asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: "CategoryViewCell", cellType: CategoryViewCell.self)) {
                row, element, cell in
                cell.textLabel.text = element.rawValue
                cell.backgroundColor = Theme.Color.FontOranger
            }.disposed(by: disposeBag)
        
        items.accept(caregorys)
        
        collectionView.rx.modelSelected(GNCategory.self)
            .subscribeNext { [weak self] (type) in
                guard let `self` = self else {return}
                switch type {
                case .Banifit:
                    let Banifit = BanifitViewController(category: type)
                    Banifit.title = type.rawValue
                    self.navigationController?.pushViewController(Banifit, animated: true)
                default:
                    let list = ListViewController(category: type)
                    list.title = type.rawValue
                    self.navigationController?.pushViewController(list, animated: true)
                }
        }.disposed(by: disposeBag)
        
        
    }
    
    override func setupSubViews() {
        collectionView.registerNib(CategoryViewCell.self)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
              
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Constant.UI.kScreenW - 25) / 3
        
        return CGSize(width: width, height: width)
    }
}

