//
//  V2Client.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit
import DrawerController

class V2Client: NSObject {
    static let sharedInstance = V2Client()
    
    var drawerController : DrawerController? = nil
    //stony todo
//    var centerViewController : HomeViewController? =nil
//    var centerNavigation : V2EXNavigationController? =nil

    //当前程序中，最上层的 NavigationController
//    var topNavigationController : UINavigationController {
//        get {
//            return V2Client.getTopNavigationController(V2Client.sharedInstance.centerNavigation!)
//        }
//    }
    
    fileprivate class func getTopNavigationController(_ currentNavigationController:UINavigationController) -> UINavigationController {
        if let topNav = currentNavigationController.visibleViewController?.navigationController {
            if topNav != currentNavigationController && topNav.isKind(of: UINavigationController.self){
                return getTopNavigationController(topNav)
            }
        }

        return currentNavigationController
    }
    
}
