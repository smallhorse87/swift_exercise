//
//  RightViewController.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/11.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

let RightViewControllerRightNodes = [
    rightNodeModel(nodeName: NSLocalizedString("tech" ), nodeTab: "tech"),
    rightNodeModel(nodeName: NSLocalizedString("creative" ), nodeTab: "creative"),
    rightNodeModel(nodeName: NSLocalizedString("play" ), nodeTab: "play"),
    rightNodeModel(nodeName: NSLocalizedString("apple" ), nodeTab: "apple"),
    rightNodeModel(nodeName: NSLocalizedString("jobs" ), nodeTab: "jobs"),
    rightNodeModel(nodeName: NSLocalizedString("deals" ), nodeTab: "deals"),
    rightNodeModel(nodeName: NSLocalizedString("city" ), nodeTab: "city"),
    rightNodeModel(nodeName: NSLocalizedString("qna" ), nodeTab: "qna"),
    rightNodeModel(nodeName: NSLocalizedString("hot"), nodeTab: "hot"),
    rightNodeModel(nodeName: NSLocalizedString("all"), nodeTab: "all"),
    rightNodeModel(nodeName: NSLocalizedString("r2" ), nodeTab: "r2"),
    rightNodeModel(nodeName: NSLocalizedString("nodes" ), nodeTab: "nodes"),
    rightNodeModel(nodeName: NSLocalizedString("members" ), nodeTab: "members"),
]

class RightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func maximumRightDrawerWidth() -> CGFloat{
        return 100
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

struct rightNodeModel {
    var nodeName:String?
    var nodeTab:String?
}
