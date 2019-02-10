//
//  FontSizeSliderTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class FontSizeSliderTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        self.selectionStyle = .none
        
        let leftLabel = UILabel()
        leftLabel.font = v2Font(14 * 0.8)
        leftLabel.text = "A"
        leftLabel.textAlignment = .center
        self.contentView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(30)
            make.left.equalTo(self.contentView)
        }
        
        let rightLabel = UILabel()
        rightLabel.font = v2Font(14 * 1.6)
        rightLabel.text = "A"
        rightLabel.textAlignment = .center
        self.contentView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(30)
            make.right.equalTo(self.contentView)
        }
        
        let slider = V2Slider()
        slider.valueChanged = { (fontSize) in
            let size = fontSize * 0.05 + 0.8
            if V2Style.sharedInstance.fontScale != size {
                V2Style.sharedInstance.fontScale = size
            }
        }
        self.contentView.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.left.equalTo(leftLabel.snp.right)
            make.right.equalTo(rightLabel.snp.left)
            make.centerY.equalTo(self.contentView)
        }
        
        let topSeparator = UIImageView()
        self.contentView.addSubview(topSeparator)
        topSeparator.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(SEPARATOR_HEIGHT)
        }
        
        let bottomSeparator = UIImageView()
        self.contentView.addSubview(bottomSeparator)
        bottomSeparator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(SEPARATOR_HEIGHT)
        }
        
        self.themeChnagedHandler = {[weak self](style) -> Void in
            self?.backgroundColor = V2EXColor.colors.v2_CellWhiteBackgroundColor
            leftLabel.textColor = V2EXColor.colors.v2_TopicListTitleColor
            rightLabel.textColor = V2EXColor.colors.v2_TopicListTitleColor
            topSeparator.image = createImageWithColor(V2EXColor.colors.v2_SeparatorColor)
            bottomSeparator.image = topSeparator.image
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
