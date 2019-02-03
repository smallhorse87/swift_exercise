//
//  SVProgressHUD+Extension.swift
//  swift_exercise
//
//  Created by mac on 2019/2/3.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import SVProgressHUD

extension SVProgressHUD {
    /**
     替换SVProgressHUB控件中弹框停留时间的计算方法，让汉字比字符停留更久的时间
     不然 abcde 和 我是大帅哥 停留的时间一样，就感觉隐藏的太快了
     */
    func displayDurationForString(_ string:String) -> TimeInterval {
        return min(Double(string.utf8.count) * 0.06 + 0.5, 5.0)
    }
}
