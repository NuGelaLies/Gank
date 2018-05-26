//
//  BaseTabBarController.swift
//  Gank
//
//  Created by NuGelaLiee on 2018/3/21.
//

import UIKit
import ReactorKit

class BaseTabBarController: UITabBarController {
    //主页
    lazy var main: MainViewController = {
        let m = MainViewController()
        m.reactor = MainCategoryReactor()
        return m
    }()
    //分类
    lazy var category: CategoryViewController = {
        let cate = CategoryViewController()
        cate.reactor = CategoryViewReactor()
        return cate
    }()
    //我的
    lazy var mine: MineViewController = {
        return MineViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChirld(Controller: main, name: "主页", nomalIMG: "new", selectIMG: "new_active")
        addChirld(Controller: category, name: "分类", nomalIMG: "category", selectIMG: "category_active")
        addChirld(Controller: mine, name: "我的", nomalIMG: "me", selectIMG: "me_active")
    }
    
    func addChirld(Controller: UIViewController, name: String, nomalIMG n: String, selectIMG s: String) {
        Controller.title = name
        Controller.tabBarItem.image = UIImage.init(named: n)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        Controller.tabBarItem.selectedImage = UIImage.init(named: s)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        Controller.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.colorWith(r: 201, g: 141, b: 44)], for: .selected)
        Controller.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor :Theme.UI.FontDarkGrayColor], for: .normal)
        let navi = BaseNavigationController.init(rootViewController: Controller)
        self.addChildViewController(navi)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
