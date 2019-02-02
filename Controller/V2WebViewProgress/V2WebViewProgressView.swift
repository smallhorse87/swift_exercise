//
//  V2WebViewProgressView.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

@objc protocol V2WebViewProgressDelegate : UIWebViewDelegate {
    @objc optional func webViewProgress(_ webViewProgress: V2WebViewProgress,progress:Float)
}

class V2WebViewProgress: NSObject,UIWebViewDelegate {
    
}

class V2WebViewProgressView: UIView {

}
