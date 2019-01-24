//
//  IssueDisplayable.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Foundation

protocol IssueDisplayable {
    var id: Id.Issue { get }
    var title: String { get }
    var owner: String { get }
}
