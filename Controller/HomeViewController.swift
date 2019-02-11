//
//  HomeViewController.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import UIKit
import SnapKit

import Alamofire
import AlamofireObjectMapper

import Ji
import MJRefresh

import SVProgressHUD

let kHomeTab = "me.fin.homeTab"

class HomeViewController: UIViewController {

    var toplicList:Array<TopicListModel>?
    var tab:String? = nil {
        didSet{
            var name = "全部"
            for model in RightViewControllerRightNodes {
                if model.nodeTab == tab {
                    name = model.nodeName ?? "" //stony 为啥是两个问号
                    break;
                }
            }
            self.title = name
        }
    }
    
    var currentPage = 0
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.cancelEstimatedHeight()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        regClass(tableView, cell: HomeTopicListTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tab = V2EXSettings.sharedInstance[kHomeTab] //stony 下标的用法
        self.setupNavigationItem()
        
        //监听程序即将进入前台运行、进入后台休眠 事件
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.applicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.view)
        }
        self.tableView.mj_header = V2RefreshHeader(refreshingBlock: {[weak self] () -> Void in
            self?.refresh()
        })
        self.refreshPage()
        
        let footer = V2RefreshFooter(refreshingBlock: {[weak self] () -> Void in
            self?.getNextPage()
        })
        footer?.centerOffset = -4
        self.tableView.mj_footer = footer
        
        self.themeChnagedHandler = {[weak self] (style) -> Void in
            self?.tableView.backgroundColor = V2EXColor.colors.v2_backgroundColor
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        V2Client.sharedInstance.drawerController?.openDrawerGestureModeMask = .panningCenterView
    }
    override func viewWillDisappear(_ animated: Bool) {
        V2Client.sharedInstance.drawerController?.openDrawerGestureModeMask = []
    }
    func setupNavigationItem(){
        let leftButton = NotificationMenuButton()
        leftButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        leftButton.addTarget(self, action: #selector(HomeViewController.leftClick), for: .touchUpInside)
        
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightButton.contentMode = .center
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15)
        rightButton.setImage(UIImage.imageUsedTemplateMode("ic_more_horiz_36pt")!.withRenderingMode(.alwaysTemplate), for: UIControlState())
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        rightButton.addTarget(self, action: #selector(HomeViewController.rightClick), for: .touchUpInside)
    }
    @objc func leftClick() {
        V2Client.sharedInstance.drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
    @objc func rightClick() {
        V2Client.sharedInstance.drawerController?.toggleRightDrawerSide(animated: true, completion: nil)
    }
    
    func refreshPage() {
        self.tableView.mj_header.beginRefreshing()
        V2EXSettings.sharedInstance[kHomeTab] = tab
    }
    func refresh() {
        if self.tableView.mj_footer.isRefreshing {
            self.tableView.mj_footer.endRefreshing()
        }
        
        //stony 这是哪门子赋值方式？
        _ = TopicListApi.provider.requestAPI(.topicList(tab: tab, page: 0)).mapResponseToJiArray(TopicListModel.self)
            .subscribe(onNext:{ (response) in
                self.toplicList = response
                self.tableView.reloadData()
                
                let refreshFooter = self.tableView.mj_footer as! V2RefreshFooter
                if self.tab == nil || self.tab == "all" {
                    refreshFooter.noMoreDataStateString = nil
                    refreshFooter.resetNoMoreData()
                }
                else {
                    refreshFooter.noMoreDataStateString = "没有更多帖子了，只有【\(NSLocalizedString("all"))】便签能翻页"
                    refreshFooter.endRefreshingWithNoMoreData()
                }
                
                //重置page
                self.currentPage = 0
                self.tableView.mj_header.endRefreshing()
                
            }, onError: {(error) in
                if let err = error as? ApiError {
                    switch err {
                    case .needs2FA:
                        //stony debug
                        //V2Client.sharedInstance.centerViewController!.navigationController?.present(TwoFAViewController(), animated:true, completion: nil)
                        SVProgressHUD.showError(withStatus: err.rawString())
                    default:
                        SVProgressHUD.showError(withStatus: err.rawString())
                    }
                }
                else {
                    SVProgressHUD.showError(withStatus: error.rawString())
                }
                self.tableView.mj_header.endRefreshing()
            })
    }
    
    func getNextPage() -> Void {
        if let count = self.toplicList?.count , count <= 0 {
            self.tableView.mj_footer.endRefreshing()
            return
        }
        
        //根据 tab name 获取帖子列表
        self.currentPage += 1
        _ = TopicListApi.provider
            .requestAPI(.topicList(tab: tab, page: self.currentPage))
            .mapResponseToJiArray(TopicListModel.self)
            .subscribe(onNext: {(response) in
                if response.count > 0 {
                    self.toplicList? += response
                    self.tableView.reloadData()
                }
                self.tableView.mj_footer.endRefreshing()
            }, onError: { (error) in
                self.currentPage -= 1
                SVProgressHUD.showError(withStatus: error.rawString())
                self.tableView.mj_footer.endRefreshing()
            })
    }
    
    static var lastLeaveTime = Date()
    @objc func applicationWillEnterForeground() {
        let interval = -1 * HomeViewController.lastLeaveTime.timeIntervalSinceNow
        if interval > 120 {
            self.tableView.mj_header.beginRefreshing()
        }
    }
    
    @objc func applicationDidEnterBackground() {
        HomeViewController.lastLeaveTime = Date()
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

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.toplicList {
            return list.count
        }
        
        return 0
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.toplicList![indexPath.row]
        let titleHeight = item.topicTitleLayout?.textBoundingRect.size.height ?? 0
        let height = 12 + 35 + 12 + titleHeight + 12 + 8
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getCell(tableView, cell: HomeTopicListTableViewCell.self, indexPath: indexPath)
        cell.bind(self.toplicList![indexPath.row])
        return cell
    }
    
    func tablewView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.toplicList![indexPath.row]
        
        if let id = item.topicId {
//stony todo
//            let topicDetailController = TopicDetailViewController()
//            topicDetailController.topicId = id
//            topicDetailController.ignoreTopicHandler = {[weak self] (topicId) in
//                self?.perform(#selector(HomeViewController.ignoreTopicHandler(_:)), with: topicId, afterDelay:0.6)
//            }
//            self.navigationController?.pushViewController(topicDetailController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @objc func ignoreTopicHandler(_ topicId:String) {
        //stony 这是个什么玩法
        let index = self.toplicList?.index(where:{$0.topicId == topicId})
        if index == nil {
            return
        }
        
        //看当前忽略的cell 是否在可视列表里
        let indexPaths = self.tableView.indexPathsForVisibleRows
        let visibleIndex = indexPaths?.index(where: {($0 as IndexPath).row == index})
        
        self.toplicList?.remove(at: index!)
        if visibleIndex == nil {
            self.tableView.reloadData()
            return
        }
        
        self.tableView.beginUpdates()
        
        self.tableView.deleteRows(at: [IndexPath(row: index!, section: 0)], with: .fade)
        
        self.tableView.endUpdates()
    }
}
