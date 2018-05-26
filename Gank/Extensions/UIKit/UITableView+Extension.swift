import UIKit

// swiftlint:disable force_cast

extension UITableView {

    func estimatedRowHeight(_ height: CGFloat) {
        self.rowHeight = UITableViewAutomaticDimension
        self.estimatedRowHeight = height
    }

    /// 隐藏 section style模式下顶部的空隙
    func hideHeaderViewSpace(_ margin: CGFloat = 0.1) {
        self.tableHeaderView = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: margin))
    }

    /// 隐藏空的Cell
    func hideEmptyCells() {
        self.tableFooterView = UIView(frame: .zero)
    }

    /// Retrive all the IndexPaths for the section.
    ///
    /// - Parameter section: The section.
    /// - Returns: Return an array with all the IndexPaths.
    public func indexPaths(section: Int) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        let rows: Int = self.numberOfRows(inSection: section)
        for i in 0 ..< rows {
            let indexPath: IndexPath = IndexPath(row: i, section: section)
            indexPaths.append(indexPath)
        }

        return indexPaths
    }
    
    func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
}
