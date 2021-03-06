//
//  TN.swift
//  todayNews
//
//  Created by NuGelaLiee on 2018/2/12.
//  Copyright © 2018年 RxTodayNews. All rights reserved.
//

import UIKit

class UBaseViewController: UIViewController {
    
    private(set) var didSetupConstraints = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalUIConfig()
        
        setupSubViews()
        
        view.setNeedsUpdateConstraints()
        
        setupRxConfig()
        
        bindViewModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            setupConstraints()
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    fileprivate func totalUIConfig() {
        view.backgroundColor = .white
    }
    
    func setupSubViews() {}
    
    func setupConstraints() {}
    
    func setupRxConfig() {}
    
    func bindViewModels() {}
    
    deinit {
        log.verbose("\(self.className) dealoc")
    }
}
