//
//  FontDisplayTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class FontDisplayTableViewCell: BaseDetailTableViewCell {

    override func setup() {
        super.setup()
        self.detailMarkHidden = true
        self.clipsToBounds = true
        self.titleLable.text = "一天，一匹小马驮着麦子去磨坊。当它驮着口袋向前跑去时，突然发现一条小河挡住了去路。小马为难了，这可怎么办呢？它向四周望了望，看见一头奶牛在河边吃草。\n\n One day, a colt took a bag of wheat to the mill. As he was running with the bag on his back, he came to a small river. The colt could not decide whether he could cross it. Looking around, he saw a cow grazing nearby."
        self.titleLable.numberOfLines = 0
        self.titleLable.preferredMaxLayoutWidth = SCREEN_WIDTH - 24
        self.titleLable.baselineAdjustment = .none
        
        self.titleLable.snp.remakeConstraints { (make) in
            make.left.top.equalTo(self.contentView).offset(12)
            make.right.equalTo(self.contentView).offset(-12)
            make.height.lessThanOrEqualTo(self.contentView).offset(-12)
        }
        
        self.kvoController.observe(V2Style.sharedInstance, keyPath: "fontScale", options: [.initial, .new]) { (_, _, _) in
            self.titleLable.font = v2ScaleFont(14)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
