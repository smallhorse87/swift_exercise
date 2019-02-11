//
//  NotificationMenuButton.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/11.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class NotificationMenuButton: UIButton {
    var aPointImageView:UIImageView?
    
    required init() {
        super.init(frame: CGRect.zero)
        self.contentMode = .center
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        self.setImage(UIImage.imageUsedTemplateMode("ic_menu_36pt")!, for: UIControlState())
        
        self.aPointImageView = UIImageView()
        self.aPointImageView!.backgroundColor = V2EXColor.colors.v2_NoticePointColor
        self.aPointImageView!.layer.cornerRadius = 4
        self.aPointImageView!.layer.masksToBounds = true
        self.addSubview(self.aPointImageView!)
        self.aPointImageView!.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(8)
            make.top.equalTo(self).offset(3)
            make.right.equalTo(self).offset(-6)
        }
        
        self.kvoController.observe(V2User.sharedInstance, keyPath: "notificationCount", options: [.initial,.new]) { [weak self](cell, clien, change) in
            if V2User.sharedInstance.notificationCount > 0 {
                self?.aPointImageView!.isHidden = false
            }
            else {
                self?.aPointImageView!.isHidden = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
