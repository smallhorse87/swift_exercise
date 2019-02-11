//
//  V2RefreshHeader.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/11.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit
import MJRefresh

class V2RefreshHeader: MJRefreshHeader {
    var loadingView:UIActivityIndicatorView?
    var arrowImage:UIImageView?
    
    override var state: MJRefreshState {
        didSet{
            switch state {
            case .idle:
                self.loadingView?.isHidden = true
                self.arrowImage?.isHidden  = false
                self.loadingView?.stopAnimating()

            case .pulling:
                self.loadingView?.isHidden = false
                self.arrowImage?.isHidden  = true
                self.loadingView?.startAnimating()
                
            case .refreshing:
                self.loadingView?.isHidden = false
                self.arrowImage?.isHidden  = true
                self.loadingView?.startAnimating()

            default:
                NSLog("")
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        self.mj_h = 50
        
        self.loadingView = UIActivityIndicatorView(activityIndicatorStyle: .white)
        self.addSubview(self.loadingView!)
        
        self.arrowImage = UIImageView(image: UIImage.imageUsedTemplateMode("ic_arrow_downward"))
        self.addSubview(self.arrowImage!)
        
        self.themeChnagedHandler = { [weak self] (style) -> Void in
            if V2EXColor.sharedInstance.style == V2EXColor.V2EXColorStyleDefault {
                self?.loadingView?.activityIndicatorViewStyle = .gray
                self?.arrowImage?.tintColor = UIColor.gray
            }
            else {
                self?.loadingView?.activityIndicatorViewStyle = .white
                self?.arrowImage?.tintColor = UIColor.gray
            }
            
        }
    }
    
    /**
     在这里设置子控件的位置和尺寸
     */
    override func placeSubviews() {
        super.placeSubviews()
        self.loadingView!.center = CGPoint(x: self.mj_w/2, y: self.mj_h/2)
        self.arrowImage!.frame = CGRect(x:0,y:0,width:24,height:24)
        self.arrowImage!.center = self.loadingView!.center
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
