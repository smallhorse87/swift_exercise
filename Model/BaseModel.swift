//
//  BaseModel.swift
//  swift_exercise
//
//  Created by mac on 2019/2/4.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

import ObjectMapper
import Ji
import Moya

class BaseJsonModel: Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {

    }
}

protocol BaseHtmlModelProtocel {
    init(rootNode:JiNode)
}

/// 实现这个协议的类，可用于Moya自动解析出这个类的model的对象数组
protocol HtmlModelArrayProtocol {
    static func createModelArray(ji:Ji) -> [Any]
}

/// 实现这个协议的类，可用于Moya自动解析出这个类的model的对象
protocol HtmlModelProtocol {
    static func createModel(ji:Ji) -> Any
}
