//
//  V2EXNavigationController.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

import YYText

class V2EXNavigationController: UINavigationController {

    /// 毛玻璃效果的 navigationBar背景
    var frostedView:UIToolbar = UIToolbar()
    /// navigationBar 阴影
    var shadowImage:UIImage?
    /// navigationBar 背景透明度
    var navigationBarAlpha:CGFloat{
        get {
            return self.frostedView.alpha
        }
        set {
            var value = newValue
            if newValue > 1 {
                value = 1
            }
            else if value < 0 {
                value = 0
            }
            self.frostedView.alpha = newValue
            if value == 1 {
                if self.navigationBar.shadowImage != nil {
                    self.navigationBar.shadowImage = nil
                }
            }
            else {
                if self.navigationBar.shadowImage == nil {
                    self.navigationBar.shadowImage = UIImage()
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            if V2EXColor.sharedInstance.style == V2EXColor.V2EXColorStyleDefault {
                return .default
            }
            else {
                return .lightContent
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(createImageWithColor(UIColor.clear), for: .default)

        let maskingView = UIView()
        
        maskingView.isUserInteractionEnabled = false
        maskingView.backgroundColor = UIColor(white: 0, alpha: 0.0)
        self.navigationBar.superview!.insertSubview(maskingView, belowSubview: self.navigationBar)
        maskingView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: NavigationBarHeight)
        // Do any additional setup after loading the view.
        
        self.frostedView.isUserInteractionEnabled = false
        self.frostedView.clipsToBounds = true
        maskingView.addSubview(self.frostedView)
        self.frostedView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(maskingView)
        }
        
        self.themeChnagedHandler = { [weak self] (style) -> Void in
            self?.navigationBar.tintColor = V2EXColor.colors.v2_navigationBarTintColor
            
            self?.navigationBar.titleTextAttributes = [
                NSAttributedStringKey.font :v2Font(18),
                NSAttributedStringKey.foregroundColor : V2EXColor.colors.v2_TopicListTitleColor
            ]
            
            if V2EXColor.sharedInstance.style == V2EXColor.V2EXColorStyleDefault {
                self?.frostedView.barStyle = .default
                self?.setNeedsStatusBarAppearanceUpdate()
                
                //全局键盘颜色
                UITextView.appearance().keyboardAppearance = .light;
                UITextField.appearance().keyboardAppearance = .light;
                YYTextView.appearance().keyboardAppearance = .light;
            }
            else {
                self?.frostedView.barStyle = .black
                self?.setNeedsStatusBarAppearanceUpdate()
                
                UITextView.appearance().keyboardAppearance = .dark;
                UITextField.appearance().keyboardAppearance = .dark;
                YYTextView.appearance().keyboardAppearance = .dark;
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
