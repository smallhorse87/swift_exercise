//
//  LeftNodeTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class LeftNodeTableViewCell: UITableViewCell {

    var nodeImageView : UIImageView = UIImageView()
    var nodeNameLabel : UILabel = {
        let label = UILabel()
        label.font = v2Font(16)
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
    
    func setup() -> Void {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        self.contentView.addSubview(panel)
        panel.addSubview(self.nodeImageView)
        panel.addSubview(self.nodeNameLabel)
        
        panel.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(55)
        }
        
        self.nodeImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(panel)
            make.left.equalTo(panel).offset(20)
            make.width.height.equalTo(25)
        }
        
        self.nodeNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nodeImageView.snp.right).offset(20)
            make.centerY.equalTo(self.nodeImageView)
        }
        
        self.themeChnagedHandler = {[weak self](style) in
            self?.configureColor()
        }
    }
    
    func configureColor() {
        self.panel.backgroundColor = V2EXColor.colors.v2_LeftNodeBackgroundColor
        self.nodeImageView.tintColor = V2EXColor.colors.v2_LeftNodeTintColor
        self.nodeNameLabel.textColor = V2EXColor.colors.v2_LeftNodeTintColor
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

class LeftNotifictionCell: LeftNodeTableViewCell {
    var notifictionCountLabel:UILabel = {
       let label = UILabel()
        label.font = v2Font(10)
        label.textColor = UIColor.white
        label.layer.cornerRadius = 7
        label.layer.masksToBounds = true
        label.backgroundColor = V2EXColor.colors.v2_NoticePointColor

        return label;
    }()
    
    override func setup() {
        super.setup()
        self.nodeNameLabel.text = NSLocalizedString("notifications")
        
        self.contentView.addSubview(self.notifictionCountLabel)
        self.notifictionCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.nodeNameLabel)
            make.left.equalTo(self.nodeNameLabel.snp.right).offset(5)
            make.height.equalTo(14)
        }
        
        self.kvoController.observe(V2User.sharedInstance, keyPath:"notificationCount", options: [.initial,.new]) { [weak self](cell, clien, change)-> Void in
            if V2User.sharedInstance.notificationCount > 0 {
                self?.notifictionCountLabel.text = "   \(V2User.sharedInstance.notificationCount)   "
            }
            else {
                self?.notifictionCountLabel.text = ""
            }
        }
    }
}
