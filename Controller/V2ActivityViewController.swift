//
//  V2ActivityViewController.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit

@objc protocol V2ActivityViewDataSource {
    /**
     获取有几个，当前不考虑复用，最多仅支持4个，之后会考虑复用并可以返回Int.max多个。
     **/
    func V2ActivityView(_ activityView:V2ActivityViewController, numberOfCellsInSection section: Int) -> Int
    
    /**
     返回Activity，主要是标题和图片
     */
    func V2ActivityView(_ activityView:V2ActivityViewController, ActivityAtIndexPath indexPath:IndexPath) -> V2Activity
    
    /**
     有多少组，和UITableView一样。
     */
    @objc optional func numberOfSectionInV2ActivityView(_ activityView:V2ActivityViewController) -> Int
    
    @objc optional func V2ActivityView(_ activityView:V2ActivityViewController, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func V2ActivityView(_ activityView:V2ActivityViewController, heightForFooterInSection section: Int) -> CGFloat
    @objc optional func V2ActivityView(_ activityView:V2ActivityViewController, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func V2ActivityView(_ activityView:V2ActivityViewController, viewForFooterInSection section: Int) -> UIView?
    
    @objc optional func V2ActivityView(_ activityView:V2ActivityViewController, didSelectRowAtIndexPath indexPath: IndexPath)
    
}

class V2Activity: NSObject {
    var title:String
    var image:UIImage
    init(title aTitle:String, image aImage:UIImage) {
        title = aTitle
        image = aImage
    }
}

class V2ActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
