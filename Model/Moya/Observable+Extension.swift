//
//  Observable+Extension.swift
//  swift_exercise
//
//  Created by mac on 2019/2/3.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import SwiftyJSON
import Moya
import Ji

public enum ApiError : Swift.Error {
    case Error(info: String)
    case AccountBanned(info: String)
    case LoginPermissionRequired(info: String)
    case needs2FA(info: String) //需要两步验证
}

extension Swift.Error {
    func rawString() -> String {
        guard let err = self as? ApiError else {
            return self.localizedDescription
        }
        switch err {
        case let .Error(info):
            return info
        case let .AccountBanned(info):
            return info
        case let .LoginPermissionRequired(info):
            return info
        case .needs2FA(let info):
            return info
        }
    }
}

//MARK: = JSON解析相关
extension Observable where Element: Moya.Response {
    /// 过滤 HTTP 错误，例如超时，请求失败等
    func filterHttpError() -> Observable<Element> {
        return filter { response in
            if (200...209) ~= response.statusCode {
                return true
            }
            print("网络错误")
            throw ApiError.Error(info: "网络错误")
        }
    }
    
    /// 过滤逻辑错误，例如协议里返回 错误CODE
    func filterResponseError() -> Observable<JSON> {
        return filterHttpError().map({ (response) -> JSON in
            let json = JSON(data: response.data)
            var code = 200
            var msg = ""
            if let codeStr = json["code"].rawString(), let c = Int(codeStr) {
                code = c
            }
            if json["msg"].exists() {
                msg = json["msg"].rawString()!
            }
            else if json["message"].exists() {
                msg = json["message"].rawString()!
            }
            else if json["info"].exists() {
                msg = json["info"].rawString()!
            }
            else if json["description"].exists() {
                msg = json["description"].rawString()!
            }
            if(code==200 || code==99999 || code==80001 || code==1) {
                return json
            }
            switch code {
            default: throw ApiError.Error(info: msg)
            }
        })
    }
}
