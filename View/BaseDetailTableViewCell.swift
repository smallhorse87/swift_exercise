//
//  BaseDetailTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

class BaseDetailTableViewCell: UITableViewCell {

    var titleLable:UILabel = {
        let label = UILabel()
        label.font = v2Font(16)
        return label
    }()
    
    var detailLable:UILabel = {
        let label = UILabel()
        label.font = v2Font(13)
        return label
    }()
    
    var detailMarkImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage.imageUsedTemplateMode("ic_keyboard_arrow_right"))
        imageView.contentMode = .center
        return imageView
    }()
    
    var separator:UIImageView = UIImageView()
    
    var detailMarkHidden:Bool {
        get {
            return self.detailMarkImageView.isHidden
        }
        
        set{
            if self.detailMarkImageView.isHidden == newValue {
                return
            }
            
            self.detailMarkImageView.isHidden = newValue
            if newValue {
                self.detailMarkImageView.snp.remakeConstraints{ (make) -> Void in
                    make.width.height.equalTo(0)
                    make.centerY.equalTo(self.contentView)
                    make.right.equalTo(self.contentView).offset(-12)
                }
            }
            else {
                self.detailMarkImageView.snp.remakeConstraints { (make) in
                    make.width.height.equalTo(20)
                    make.centerY.equalTo(self.contentView)
                    make.right.equalTo(self.contentView).offset(-12)
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup()->Void {
        let selectedBackgroundView = UIView()
        self.selectedBackgroundView = selectedBackgroundView
        
        self.contentView.addSubview(self.titleLable)
        self.contentView.addSubview(self.detailMarkImageView)
        self.contentView.addSubview(self.detailLable)
        self.contentView.addSubview(self.separator)
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(12)
            make.centerY.equalTo(self.contentView)
        }
        
        self.detailMarkImageView.snp.remakeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(14)
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-12)
        }
        
        self.detailLable.snp.makeConstraints { (make) in
            make.right.equalTo(self.detailMarkImageView.snp.left).offset(-5)
            make.centerY.equalTo(self.contentView)
        }
        
        self.separator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(SEPARATOR_HEIGHT)
        }
        
        self.themeChnagedHandler = {[weak self] (style) -> Void in
            self?.backgroundColor = V2EXColor.colors.v2_CellWhiteBackgroundColor
            self?.selectedBackgroundView!.backgroundColor = V2EXColor.colors.v2_backgroundColor
            self?.titleLable.textColor = V2EXColor.colors.v2_TopicListTitleColor
            self?.detailMarkImageView.tintColor = self?.titleLable.textColor
            self?.detailLable.textColor = V2EXColor.colors.v2_TopicListUserNameColor
            self?.separator.image = createImageWithColor(V2EXColor.colors.v2_SeparatorColor)
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
