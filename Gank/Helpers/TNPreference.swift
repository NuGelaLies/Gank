//
//  TNPreference.swift
//  todayNews
//
//  Created by NuGelaLiee on 2018/2/12.
//  Copyright © 2018年 RxTodayNews. All rights reserved.
//

import UIKit

class TNPreference {
    
    public static let shared: TNPreference = TNPreference()
    
    /// 是否启用全屏返回手势， 默认 true
    var enableFullScreenGesture: Bool {
        set {
            UserDefaults.save(at: newValue, forKey: Constant.Config.fullScreenBack)
        }
        get {
            return (UserDefaults.get(forKey: Constant.Config.fullScreenBack) as? Bool) ?? false
        }
    }
}
