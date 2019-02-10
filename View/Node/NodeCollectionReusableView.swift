//
//  NodeCollectionReusableView.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class NodeCollectionReusableView: UICollectionReusableView {
    var label: UILabel = {
        let _label = UILabel()
        _label.font = v2Font(16)
        _label.textColor = V2EXColor.colors.v2_TopicListTitleColor
        _label.backgroundColor = V2EXColor.colors.v2_backgroundColor
        return _label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = V2EXColor.colors.v2_backgroundColor
        
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(15)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
