//
//  HomeTopicListTableViewCell.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/10.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit
import Kingfisher
import YYText


class HomeTopicListTableViewCell: UITableViewCell {
    
    //? 为什么用这个圆角图片，而不用layer.conerRadius
    //因为设置 layer.cornerRadius 太耗系统资源，每次滑动，多需要渲染很多次，所以滑动掉帧
    //iOS中可以缓存渲染，但效果还是不如直接 用圆角图片
    
    /// 节点信息lable的圆角背景图
    fileprivate static var nodeBackgroundImage_Default =
        createImageWithColor(V2EXDefaultColor.sharedInstance.v2_NodeBackgroundColor, size: CGSize(width: 10, height: 20)).roundedCornerImageWithCornerRadius(2).stretchableImage(withLeftCapWidth: 2, topCapHeight: 3)
    fileprivate static var nodeBackgroundImage_Dark =
        createImageWithColor(V2EXDarkColor.sharedInstance.v2_NodeBackgroundColor, size: CGSize(width: 10, height: 20)).roundedCornerImageWithCornerRadius(2).stretchableImage(withLeftCapWidth: 3, topCapHeight: 3)

    ///头像
    var avatarImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }()
    
    /// 用户名
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = v2Font(14)
        return label
    }()
    ///stony 这是个什么语法？
    
    /// 日期 和 最后发送人
    var dateAndLastPostUserLabel: UILabel = {
        let label = UILabel()
        label.font = v2Font(12)
        return label
    }()
    
    /// 评论数量
    var replyCountLabel: UILabel = {
        let label = UILabel()
        label.font = v2Font(12)
        return label
    }()
    
    var replyCountIconImageView: UIImageView = {
        let imageview = UIImageView(image: UIImage(named: "reply_n"))
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    /// 节点
    var nodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = v2Font(11)
        return label
    }()
    var nodeBackgroundImageView:UIImageView = UIImageView()
    
    ///帖子标题
    var topicTitleLable: YYLabel = {
        let label = YYLabel()
        label.textVerticalAlignment = .top
        label.font = v2Font(18)
        label.displaysAsynchronously = true
        label.numberOfLines = 0
        return label
    }()
    
    /// 装上面定义的那些元素的容器
    var contentPanel:UIView = UIView()
    
    var itemModel:TopicListModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    func setup() {
        let selectedBackgroundView = UIView()
        self.selectedBackgroundView = selectedBackgroundView
        
        self.contentView.addSubview(self.contentPanel)
        self.contentPanel.addSubview(self.avatarImageView)
        self.contentPanel.addSubview(self.userNameLabel)
        self.contentPanel.addSubview(self.dateAndLastPostUserLabel)
        self.contentPanel.addSubview(self.replyCountLabel)
        self.contentPanel.addSubview(self.replyCountIconImageView)
        self.contentPanel.addSubview(self.nodeBackgroundImageView)
        self.contentPanel.addSubview(self.nodeNameLabel)
        self.contentPanel.addSubview(self.topicTitleLable)
        
        self.setupLayout()
        
        //stony [weak self] 这是个什么用法
        self.themeChnagedHandler = { [weak self] (style) -> Void in
            if style == V2EXColor.V2EXColorStyleDefault {
                self?.nodeBackgroundImageView.image = HomeTopicListTableViewCell.nodeBackgroundImage_Default
            }
            else {
                self?.nodeBackgroundImageView.image = HomeTopicListTableViewCell.nodeBackgroundImage_Dark
            }
            
            self?.backgroundColor = V2EXColor.colors.v2_backgroundColor
            self?.selectedBackgroundView!.backgroundColor = V2EXColor.colors.v2_backgroundColor
            self?.contentPanel.backgroundColor = V2EXColor.colors.v2_CellWhiteBackgroundColor
            self?.userNameLabel.textColor = V2EXColor.colors.v2_TopicListUserNameColor
            self?.dateAndLastPostUserLabel.textColor = V2EXColor.colors.v2_TopicListDateColor
            self?.replyCountLabel.textColor = V2EXColor.colors.v2_TopicListDateColor
            self?.nodeNameLabel.textColor = V2EXColor.colors.v2_TopicListDateColor
            self?.topicTitleLable.textColor = V2EXColor.colors.v2_TopicListTitleColor
            
            self?.avatarImageView.backgroundColor = self?.contentPanel.backgroundColor
            self?.userNameLabel.backgroundColor = self?.contentPanel.backgroundColor
            self?.dateAndLastPostUserLabel.backgroundColor = self?.contentPanel.backgroundColor
            self?.replyCountLabel.backgroundColor = self?.contentPanel.backgroundColor
            self?.replyCountIconImageView.backgroundColor = self?.contentPanel.backgroundColor
            self?.topicTitleLable.backgroundColor = self?.contentPanel.backgroundColor
        }
        
        //点击用户头像，跳转到用户主页
        self.avatarImageView.isUserInteractionEnabled = true
        self.userNameLabel.isUserInteractionEnabled   = true
        //stony Any指的是什么 #selector是什么
        var userNameTap = UITapGestureRecognizer(target: self, action: #selector(HomeTopicListTableViewCell.userNameTap(_:)))
        self.avatarImageView.addGestureRecognizer(userNameTap)
        userNameTap = UITapGestureRecognizer(target: self, action: #selector(HomeTopicListTableViewCell.userNameTap(_:)))
        self.userNameLabel.addGestureRecognizer(userNameTap)
    }

    //stony snapkit 和 Mansory的关系
    fileprivate func setupLayout(){
        //stony 头文件关系，为什么放到了HomeViewController后，snapkit就可以使用了？
        self.contentPanel.snp.makeConstraints{ (make) -> Void in
            make.top.left.right.equalTo(self.contentView);
        }
        
        self.avatarImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.contentView).offset(12)
            make.width.height.equalTo(35)
        }
        
        self.userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.avatarImageView.snp.right).offset(10)
            make.top.equalTo(self.avatarImageView)
        }
        
        self.dateAndLastPostUserLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.avatarImageView)
            make.left.equalTo(self.userNameLabel)
        }
        
        self.replyCountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.userNameLabel)
            make.right.equalTo(self.contentPanel).offset(-12)
        }
        
        self.replyCountIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.replyCountLabel)
            make.width.height.equalTo(18)
            make.right.equalTo(self.replyCountLabel.snp.left).offset(-2)
        }
        
        self.nodeNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.replyCountLabel)
            make.right.equalTo(self.replyCountIconImageView.snp.left).offset(-9)
            make.bottom.equalTo(self.replyCountLabel).offset(1)
            make.top.equalTo(self.replyCountLabel).offset(-1)
        }
        
        self.nodeBackgroundImageView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.nodeNameLabel)
            make.left.equalTo(self.nodeNameLabel).offset(-5)
            make.right.equalTo(self.nodeNameLabel).offset(5)
        }
        
        self.topicTitleLable.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp.bottom).offset(12)
            make.left.equalTo(self.avatarImageView)
            make.right.equalTo(self.contentPanel).offset(-12)
            make.bottom.equalTo(self.contentView).offset(-8)
        }
        
        self.contentPanel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
        }
    }
    
    //stony @objc是什么
    @objc func userNameTap(_ sender:UITapGestureRecognizer) {
        if let _ = self.itemModel, let username = itemModel?.userName {

            let memberViewController = MemberViewController()
            memberViewController.username = username
            V2Client.sharedInstance.centerNavigation?.pushViewController(memberViewController, animated: true)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func superBind(_ model:TopicListModel) {
        self.userNameLabel.text = model.userName
        if let layout = model.topicTitleLayout {
            //如果新旧model标题相同，则不需要赋值
            //不然layout需要重新绘制，会造成刷新闪烁
            if layout.text.string == self.itemModel?.topicTitleLayout?.text.string {
                return
            }
            else {
                self.topicTitleLable.textLayout = layout
            }
        }
        
        if let avata = model.avata {
            self.avatarImageView.fin_setImageWithUrl(URL(string: "https:" + avata)!, placeholderImage: nil, imageModificationClosure: fin_defaultImageModification())
        }
        self.replyCountLabel.text = model.replies
        
        self.itemModel = model
    }
    
    func bind(_ model:TopicListModel){
        self.superBind(model)
        self.dateAndLastPostUserLabel.text = model.date
        self.nodeNameLabel.text = model.nodeName
    }

    func bindNodeModel(_ model:TopicListModel) {
        self.superBind(model)
        self.dateAndLastPostUserLabel.text = model.hits
        self.nodeBackgroundImageView.isHidden = true
    }

}
