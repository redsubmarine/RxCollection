//
//  Request.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Alamofire

protocol Request {
    associatedtype ResponseType: Decodable
    var method: HTTPMethod { get }
    var urlPath: String { get }
    var parameters: [String: Any]? { get }
    var parameterEncoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
}
