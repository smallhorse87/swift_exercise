//
//  Request+Extension.swift
//  swift_exercise
//
//  Created by chenxiaosong on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

import Foundation
import Alamofire
import Ji

extension DataRequest {
    
    static func JIHTMLResponseSerializer() -> DataResponseSerializer<Ji> {
        return DataResponseSerializer {requset, response, data, error in
            guard error == nil else {return .failure(error!)}
            
            if response?.url?.path == "/signin" && request?.url?.path != "/signin" {
                
            }
        }
    }
    
    @discardableResult
    public func responseJiHtml(queue: DispatchQueue? = nil, completionHandler: @escaping(DataResponse<Ji>) -> Void) -> Self {
        return response(responseSerializer: Alamofire.DataRequest.JIHTMLResponseSerializer(), completionHandler: completionHandler)
    }
}
