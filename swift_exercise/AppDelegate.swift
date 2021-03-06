//
//  AppDelegate.swift
//  swift_exercise
//
//  Created by mac on 2019/2/2.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

import DrawerController
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        URLProtocol.registerClass(WebViewImageProtocol.self)
        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.makeKeyAndVisible()
        
        let centerNav = V2EXNavigationController(rootViewController: HomeViewController())
        let leftViewController = LeftViewController()
        let rightViewController = RightViewController()
        let drawerController = DrawerController(centerViewController: centerNav, leftDrawerViewController: leftViewController, rightDrawerViewController:rightViewController)
        
        self.window?.themeChnagedHandler = { [weak self] (style) -> Void in
            self?.window?.backgroundColor = V2EXColor.colors.v2_backgroundColor
        }
        
        drawerController.maximumLeftDrawerWidth=230
        drawerController.maximumRightDrawerWidth = rightViewController.maximumRightDrawerWidth()
        drawerController.openDrawerGestureModeMask = OpenDrawerGestureMode.panningCenterView
        drawerController.closeDrawerGestureModeMask = CloseDrawerGestureMode.all
        self.window?.rootViewController = drawerController
        
        V2Client.sharedInstance.drawerController = drawerController
        V2Client.sharedInstance.centerViewController = centerNav.viewControllers[0] as? HomeViewController
        V2Client.sharedInstance.centerNavigation = centerNav
        
        #if DEBUG
            let fpsLabel = V2FPSLabel(frame: CGRect(x: 15, y: SCREEN_HEIGHT-40, width: 55, height: 20))
            self.window?.addSubview(fpsLabel)
        #else
        #endif
        
        SVProgressHUD.setForegroundColor(UIColor(white: 1, alpha: 1))
        SVProgressHUD.setBackgroundColor(UIColor(white: 0.15, alpha: 0.85))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
        SVProgressHUD.setContainerView(self.window!)
        
        #if DEBUG
        #else
        Fabric.with([Crashlytics.self])
        #endif
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    fileprivate var lastPasteString: String?
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if let pasteString = UIPasteboard.general.string {
            guard lastPasteString != pasteString else {
                return
            }
            self.lastPasteString = pasteString
            
            let result = AnalyzURLResultType(url: pasteString)
            switch result {
            case .member(let member):
                let controller = UIAlertController(title: "是否打开用户主页？", message: pasteString, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "打开", style: .default, handler: {(_) in
                    member.run()
                }))
                controller.addAction(UIAlertAction(title: "忽略", style: .cancel, handler: nil))
                V2Client.sharedInstance.centerNavigation?.present(controller, animated: true, completion: nil)
            
            case .topic(let topic):
                let controller = UIAlertController(title: "是否打开帖子？", message: pasteString, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "打开", style: .default, handler: {(_) in
                    topic.run()
                }))
                controller.addAction(UIAlertAction(title: "忽略", style: .cancel, handler: nil))
                V2Client.sharedInstance.centerNavigation?.present(controller, animated: true, completion: nil)
                
            default:
                return
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

