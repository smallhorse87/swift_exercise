//
//  TopicListApi.swift
//  swift_exercise
//
//  Created by mac on 2019/2/3.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

enum TopicListApi {
    //获取首页列表
    case topicList(tab: String?, page : Int)
    //获取我的收藏帖子列表
    case favoriteList(page: Int)
    //获取节点主题列表
    case nodeTopicList(nodeName: String, page:Int)
}

extension TopicListApi: V2EXTargetType {
    var parameters: [String : Any]? {
        switch self {
        case let .topicList(tab, page):
            if tab == "all" && page > 0 {
                //只有全部分类能翻页
                return ["p": page]
            }
            return ["tab":tab ?? "all"]
        
        case let .favoriteList(page):
            return ["p": page]
            
        case let .nodeTopicList(_, page):
            return ["p": page]
        }
    }
    
    var path: String {
        switch self {
        case let .topicList(tab, page):
            if tab == "all" && page > 0 {
                return "/recent"
            }
            return "/"
            
        case .favoriteList:
            return "my/topics"
            
        case let .nodeTopicList(nodeName, _):
            return "/go/\(nodeName)"
        }
    }
}
