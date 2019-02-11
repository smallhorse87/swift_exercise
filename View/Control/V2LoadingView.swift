//
//  V2LoadingView.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/11.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

let noticeString = [
    "正在拼命加载",
    "前方发现楼主",
    "年轻人,不要着急",
    "让我飞一会儿",
    "大爷,您又来了?",
    "楼主正在抓皮卡丘，等他一会儿吧",
    "爱我，就等我一万年",
    "未满18禁止入内",
    "正在前往 花村",
    "正在前往 阿努比斯神殿",
    "正在前往 沃斯卡娅工业区",
    "正在前往 观测站：直布罗陀",
    "正在前往 好莱坞",
    "正在前往 66号公路",
    "正在前往 国王大道",
    "正在前往 伊利奥斯",
    "正在前往 漓江塔",
    "正在前往 尼泊尔"
]

class V2LoadingView: UIView {
    var activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    init(){
        super.init(frame: CGRect.zero)
        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-32)
        }
        
        let noticeLabel = UILabel()
        
        noticeLabel.text = noticeString[Int(arc4random() % UInt32(noticeString.count))]
        noticeLabel.font = v2Font(10)
        noticeLabel.textColor = V2EXColor.colors.v2_TopicListDateColor
        self.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.activityIndicatorView.snp.bottom).offset(10)
            make.centerX.equalTo(self.activityIndicatorView)
        }
        
        self.themeChnagedHandler = { [weak self] (style) -> Void in
            if V2EXColor.sharedInstance.style == V2EXColor.V2EXColorStyleDefault {
                self?.activityIndicatorView.activityIndicatorViewStyle = .gray
            }
            else {
                self?.activityIndicatorView.activityIndicatorViewStyle = .white
            }
            
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        self.activityIndicatorView.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hide(){
        super.superview?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: 0.2,
                       animations: {()->Void in
                        self.alpha = 0
        }, completion: { (finished) -> Void in
            if finished {
                self.removeFromSuperview()
            }
        })
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
