//
//  UIButton+Extension.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

extension UIButton{
    
    class func roundedButton() ->UIButton {
        let btn = UIButton (type: .custom)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 3
        btn.backgroundColor = V2EXColor.colors.v2_ButtonBackgroundColor
        btn.titleLabel!.font = v2Font(14)
        btn.setTitleColor(UIColor.white, for: UIControlState())
        
        return btn
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
