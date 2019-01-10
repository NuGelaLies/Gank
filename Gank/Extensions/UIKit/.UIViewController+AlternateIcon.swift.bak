import UIKit

extension UIViewController {
    class func swizzleMethod() {
        guard #available(iOS 10.3, *) else { return }
        guard self == UIViewController.self else { return }
        
        if let presendM = class_getInstanceMethod(self, #selector(present(_:animated:completion:))),
            let presendSM = class_getInstanceMethod(self, #selector(v2Present(_:animated:completion:))) {
            method_exchangeImplementations(presendM, presendSM)
        }
    }
    
    @objc func v2Present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        if viewControllerToPresent.isKind(of: UIAlertController.self) {
            let alertController = viewControllerToPresent as? UIAlertController
            if alertController?.title == nil && alertController?.message == nil {
                return
            } else {
                v2Present(viewControllerToPresent, animated: flag, completion: completion)
                return
            }
        }
        v2Present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
