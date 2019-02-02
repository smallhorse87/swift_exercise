//
//  V2WebViewViewController.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit
import WebKit

class V2WebViewViewController: UIViewController ,V2WebViewProgressDelegate ,V2ActivityViewDataSource {
    func V2ActivityView(_ activityView: V2ActivityViewController, numberOfCellsInSection section: Int) -> Int {
        //stony todo
        return 0;
    }
    
    func V2ActivityView(_ activityView: V2ActivityViewController, ActivityAtIndexPath indexPath: IndexPath) -> V2Activity {
        //stony todo
        return V2Activity(title:"todo", image:UIImage(named:"todo")!);
    }
    
    init(url:String) {
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
