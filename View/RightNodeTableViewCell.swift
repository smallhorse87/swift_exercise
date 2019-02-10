//
//  RightNodeTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class RightNodeTableViewCell: UITableViewCell {

    var nodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = v2Font(15)
        return label
    }()
    
    var panel = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup()->Void {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(panel)
        self.panel.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-1*SEPARATOR_HEIGHT)
        }
        
        panel.addSubview(self.nodeNameLabel)
        self.nodeNameLabel.snp.makeConstraints { (make) in
            make.right.equalTo(panel).offset(-22)
            make.centerY.equalTo(panel)
        }
        
        self.themeChnagedHandler = { [weak self](style) -> Void in
            self?.refreshBackgroundColor()
            self?.nodeNameLabel.textColor = V2EXColor.colors.v2_LeftNodeTintColor
            
        }
    }
    
    func refreshBackgroundColor() {
        if self.isSelected {
            self.panel.backgroundColor = V2EXColor.colors.v2_LeftNodeBackgroundHighLightedColor
        }
        else {
            self.panel.backgroundColor = V2EXColor.colors.v2_LeftNodeBackgroundColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.refreshBackgroundColor()
        // Configure the view for the selected state
    }

}
