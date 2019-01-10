//
//  TNNavigationController.swift
//  todayNews
//
//  Created by NuGelaLiee on 2018/2/12.
//  Copyright © 2018年 RxTodayNews. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    var fullScreenPopGesture: UIPanGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearance()
        
        setFullScreenPopGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_back"), action: {
                self.popViewController(animated: true)
            })
            viewController.navigationItem.leftBarButtonItem?.tintColor = .white
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    /// 解决自定义backItem后手势失效的问题， 并修改为全屏返回
    func setFullScreenPopGesture() {
        let target = self.interactivePopGestureRecognizer?.delegate
        let targetView = self.interactivePopGestureRecognizer!.view
        let handler: Selector = NSSelectorFromString("handleNavigationTransition:");
        let fullScreenGesture = UIPanGestureRecognizer(target: target, action: handler)
        fullScreenPopGesture = fullScreenGesture
        
        fullScreenGesture.delegate = self
        targetView?.addGestureRecognizer(fullScreenGesture)
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func setAppearance() {
        navigationBar.barStyle = .black
        navigationBar.barTintColor = .black
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if childViewControllers.count <= 1 {
            return false
        }
        
        // 手势响应区域
        let panGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
        let location = panGestureRecognizer.location(in: view)
        let offset = panGestureRecognizer.translation(in: panGestureRecognizer.view)
       
        let area = TNPreference.shared.enableFullScreenGesture ? view.width : 50
        let ret =  0 < offset.x && location.x < area
        return ret
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UINavigationController {
    
    open override var previewActionItems : [UIPreviewActionItem] {
        if let items = topViewController?.previewActionItems {
            return items
        } else {
            return super.previewActionItems
        }
    }
}


