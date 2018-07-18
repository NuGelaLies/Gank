//
//  UITableView+Rx.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/7/18.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UITableView {
    
    func deSelectRow(animated: Bool = true) -> Binder<IndexPath> {
        return Binder(base) { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    
    var isEditing: Binder<Bool> {
        return Binder(base) { tableView, isEditing in
            tableView.setEditing(isEditing, animated: true)
        }
    }
}
