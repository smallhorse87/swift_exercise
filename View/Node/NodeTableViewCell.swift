//
//  NodeTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class NodeTableViewCell: UICollectionViewCell {
    var textLabel:UILabel = {
        let label = UILabel()
        label.font = v2Font(15)
        label.textColor = V2EXColor.colors.v2_TopicListUserNameColor
        label.backgroundColor = V2EXColor.colors.v2_CellWhiteBackgroundColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = V2EXColor.colors.v2_CellWhiteBackgroundColor
        self.contentView.addSubview(textLabel)
        
        textLabel.snp.remakeConstraints({ (make) in
            make.center.equalTo(self.contentView)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
