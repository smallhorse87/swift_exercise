//
//  V2Slider.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class V2Slider: UISlider {
    var valueChanged : ( (_ value:Float) -> Void )?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    init() {
        super.init(frame: CGRect.zero)
        self.minimumValue = 0
        self.maximumValue = 16
        self.value = (V2Style.sharedInstance.fontScale - 0.8) / 0.5 * 10
        self.addTarget(self, action:  #selector(V2Slider.valueChanged(_:)), for: [.valueChanged])
        
        self.themeChnagedHandler = {[weak self] (style) -> Void in
            self?.minimumTrackTintColor = V2EXColor.colors.v2_TopicListTitleColor
            self?.maximumTrackTintColor = V2EXColor.colors.v2_backgroundColor
        }
    }
    deinit {
        print("deinit")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func valueChanged(_ sender: UISlider) {
        sender.value = Float(Int(sender.value))
        valueChanged?(sender.value)
    }

}
