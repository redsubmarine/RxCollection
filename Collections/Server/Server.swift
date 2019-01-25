//
//  Server.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire
import RxCodable

struct Server {
    private let httpQueue = DispatchQueue(label: "http_queue")
    let baseURL: String
    
    init(baseURL: String = "https://api.github.com") {
        self.baseURL = baseURL
    }

    func request<T: Request>(_ request: T) -> Observable<T.ResponseType> {
        
        let urlString = baseURL.appending(request.urlPath)
        guard let url = URL(string: urlString) else { return .never() }
        
        return RxAlamofire.requestJSON(request.method, url,
                                       parameters: request.parameters,
                                       encoding: request.parameterEncoding,
                                       headers: request.headers)
            .observeOn(ConcurrentDispatchQueueScheduler(queue: httpQueue))
            .map({ try JSONSerialization.data(withJSONObject: $0.1, options: []) })
            .map(T.ResponseType.self, using: JSONDecoder())
    }
    
}
