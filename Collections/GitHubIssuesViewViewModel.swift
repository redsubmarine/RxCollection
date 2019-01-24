//
//  GitHubIssuesViewViewModel.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Foundation
import class RxSwift.Observable

struct GitHubIssuesViewViewModel: HasCollectionData {
    var dataSource: Observable<[SectionData]>
 
    init() {
        dataSource = .just([
            SectionData(id: "issues", items: Array(0...10)
                .map({
                CellInfo(id: "\($0)", data: .none, style: GitHubIssueCell.bundle(style: .normal))
                }))
            ])
    }
}
