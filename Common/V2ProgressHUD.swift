//
//  V2ProgressHUD.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/3.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

import SVProgressHUD

class V2ProgressHUD: NSObject {

    open class func show() {
        SVProgressHUD.show(with: .none)
    }
    
    open class func showWithClearMask() {
        SVProgressHUD.show(with: .clear)
    }
    
    open class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    open class func showWithStatus(_ status:String!) {
        SVProgressHUD.show(withStatus: status)
    }
    
    open class func success(_ status:String!) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    open class func error(_ status:String!) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    open class func inform(_ status:String!) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
}

public func V2Success(_ status:String!) {
    V2ProgressHUD.success(status)
}

public func V2Error(_ status:String!) {
    V2ProgressHUD.error(status)
}

public func V2Inform(_ status:String!) {
    V2ProgressHUD.inform(status)
}

public func V2BeginLoading() {
    V2ProgressHUD.show()
}

public func V2BeginLoadingWithStatus(_ status:String!) {
    V2ProgressHUD.showWithStatus(status)
}

public func V2EndLoading() {
    V2ProgressHUD.dismiss()
}
