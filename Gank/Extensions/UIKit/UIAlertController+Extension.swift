import UIKit

extension UIAlertController {

    func show(_ viewController: UIViewController, sourceView: UIView? = nil) {
        if UIDevice.current.isPad,
        let popPresenter = popoverPresentationController,
            let `sourceView` = sourceView {
            popPresenter.sourceView = sourceView
            popPresenter.sourceRect = sourceView.bounds
        }
        viewController.present(self, animated: true, completion: nil)
    }

}
