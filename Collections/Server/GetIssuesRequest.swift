//
//  GetIssuesRequest.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Alamofire

struct GetIssuesRequest: Request {
    typealias ResponseType = [Issue]
    var method: HTTPMethod = .get
    var urlPath: String = "/repos/firebase/firebase-ios-sdk/issues"
    var parameters: [String : Any]?
    var parameterEncoding: ParameterEncoding = URLEncoding.default
    var headers: [String : String]?
}
