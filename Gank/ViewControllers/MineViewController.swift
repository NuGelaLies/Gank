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
    
    let items = BehaviorRelay<[User]>(value: [])
    
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
    
    override func bindViewModels() {
        items.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "UITableViewCell", cellType: UITableViewCell.self)) {
                row , element , cell in
                cell.textLabel?.text = element.name
                cell.detailTextLabel?.text = element.mobile
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(User.self)
            .flatMap({ GNDBManager.shared.rx.addUser($0)})
            .subscribeNext { (isSuccess) in
                isSuccess ? print("add success") : print("add false")
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.modelDeleted(User.self)
            .concatMap({ GNDBManager.shared.rx.deleteUser($0) })
            .subscribeNext { (isDelete) in
                isDelete ? print("delete success") : print("delete false")
        }.disposed(by: rx.disposeBag)
        
    }
    
    override func setupRxConfig() {
        var users: [User] = []
        
        for i in 0..<10 {
            let item = User()
            item.name = "nugela\(i)"
            item.mobile = "1992456996\(i)"
            users.append(item)
        }
        
        items.accept(users)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
