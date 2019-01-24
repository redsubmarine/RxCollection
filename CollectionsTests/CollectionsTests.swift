//
//  CollectionsTests.swift
//  CollectionsTests
//
//  Created by 양원석 on 06/11/2018.
//  Copyright © 2018 red. All rights reserved.
//

import XCTest
@testable import Collections
import RxSwift
import RxCocoa

class CollectionsTests: XCTestCase {

    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testExample() {
        let dic = BehaviorRelay<[String: String]>(value: [:])

        let dicObservable = dic.asObservable()
        
        _ = dicObservable.map({ $0["0"] })
            .subscribe({
                print(" \($0)")
            })
        
        
        var newDic = dic.value
        newDic["0"] = "hello"
        dic.accept(newDic)
        
        newDic = dic.value
        newDic["0"] = "world"
        dic.accept(newDic)
    }

}
