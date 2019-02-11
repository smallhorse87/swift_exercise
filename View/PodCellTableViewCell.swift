//
//  PodCellTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class PodCellTableViewCell: BaseDetailTableViewCell{

    var descriptionLabel:UILabel = {
        let label = V2SpacingLabel()
        label.font = v2Font(13)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = SCREEN_WIDTH - 42
        label.textColor = V2EXColor.colors.v2_TopicListUserNameColor
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = V2EXColor.colors.v2_backgroundColor
        self.contentView.addSubview(self.descriptionLabel)
        self.setupLayout()
    }
    
    //stony study fatalError是个什么函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        self.titleLable.snp.remakeConstraints { (make) in
            make.left.top.equalTo(self.contentView).offset(12)
        }
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLable)
            make.right.equalTo(self.contentView).offset(-30)
            make.top.equalTo(self.titleLable.snp.bottom)
            make.bottom.equalTo(self.contentView).offset(-8)
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
