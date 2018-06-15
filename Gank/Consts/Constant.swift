//
//  Constant.swift
//  todayNews
//
//  Created by NuGelaLiee on 2018/2/12.
//  Copyright © 2018年 RxTodayNews. All rights reserved.
//

import UIKit
import Foundation

struct Constant {
    
    struct key {    }
    
    struct Const {
       static let pageNum = 15
    }
    
    struct web {
        static let defaultWebSite = "https://www.baidu.com"
    }
    
    struct Config {
        // 全屏返回手势
        static let fullScreenBack = "fullScreenBack"
    }
    
    struct UI {
        static let kScreenW = UIScreen.main.bounds.width
        static let kScreenH = UIScreen.main.bounds.height
    }
}

struct Theme {
    
    //MARK: 颜色
    struct UI {

        /// ViewController的背景颜色 F2F2F2
        static let SDBackgroundColor: UIColor = UIColor.hex(0xF2F2F2)
        
        /// 主题灰色line的背景色 D4D4D4
        static let AppLightGrayColor: UIColor = UIColor.hex(0xD4D4D4)
        
        /// 主题绿色 66cccc
        static let AppGreenBackagroundColor: UIColor = UIColor.hex(0x66cccc)
        
        ///黄色字体
        static let FontYellowColor: UIColor = UIColor.hex(0xffc526)
        
        /// 交易订单待处理黄色
        static let AppDealOrangeColor: UIColor = UIColor(red: 239 / 255.0, green: 131 / 255.0, blue: 22 / 255.0, alpha:1)
        /// 交易订单已取消颜色
        static let AppDealGrayColor: UIColor = UIColor(red: 201 / 255.0, green: 202 / 255.0, blue: 203 / 255.0, alpha:
            1)
        /// 蓝色
        static let FontBlueColor: UIColor = UIColor.hex(0x1a8df8)
        /// 橙色字体 较浅  fc7325
        static let FontOrangerColor: UIColor = UIColor.hex(0xfc7325)
        /// 红色字体 ff3e3e
        static let FontRedColor: UIColor = UIColor.hex(0xff3e3e)
        /// 深灰色字体  878787
        static let FontDarkGrayColor: UIColor = UIColor.hex(0x878787)
        /// 浅灰色字体  d4d4d4
        static let FontLightGrayColor: UIColor = UIColor.hex(0xd4d4d4)
        /// 最深色字体  585757
        static let DarkGrayColor: UIColor = UIColor.hex(0x585757)
    }
    
    struct Font {
        ///14
        static let Font14 = UIFont.systemFont(ofSize: 14)
        ///15
        static let Font15 = UIFont.systemFont(ofSize: 15)
        ///16
        static let Font16 = UIFont.systemFont(ofSize: 16)
        ///17
        static let Font17 = UIFont.systemFont(ofSize: 17)
    }
    
}
