//
//  BaseViewController.swift
//  swift_exercise
//
//  Created by zhitian_UI on 2019/2/12.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    fileprivate weak var _loadView:V2LoadingView!
    
    func hideLoadingView () {
        self._loadView?.removeFromSuperview()
    }
    
    func showLoadingView () {
        self.hideLoadingView()
        
        let aloadView = V2LoadingView()
        aloadView.backgroundColor = self.view.backgroundColor
        self.view.addSubview(aloadView)
        aloadView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.view)
        }
        self._loadView = aloadView
    }
    
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
