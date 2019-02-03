//
//  V2HitTestSlopButton.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/3.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class V2HitTestSlopButton: UIButton {
    var hitTestSlop:UIEdgeInsets = UIEdgeInsets.zero
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if UIEdgeInsetsEqualToEdgeInsets(hitTestSlop, UIEdgeInsets.zero) {
            return super.point(inside: point, with: event)
        }
        else{
            return UIEdgeInsetsInsetRect(self.bounds, hitTestSlop).contains(point)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
