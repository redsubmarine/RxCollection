//
//  GitHubIssuesViewViewModel.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Foundation
import class RxSwift.Observable
import class RxCocoa.BehaviorRelay

struct GitHubIssuesViewViewModel: HasCollectionData {
    var dataSource: Observable<[SectionData]>
    let server: Server
    let database: IssueDatabase
    private let issues = BehaviorRelay<[IssueDisplayable]>(value: [])
    
    init(server: Server, database: IssueDatabase) {
        self.server = server
        self.database = database
        
        dataSource = issues.asObservable()
            .map({ issues in
                [SectionData(id: "issues", items: issues.map({ issue in
                    CellInfo(id: issue.id, data: .issue(issue: issue), style: GitHubIssueCell.bundle())
                }))]
            })
    }
    
    func getIssues() {
        let request = GetIssuesRequest()
        _ = server.request(request)
            .take(1)
            .map({ $0 as [IssueDisplayable] })
            .bind(to: issues)
//            .subscribe(onNext: { issues in
//                issues.forEach(self.database.update)
//            })
    }
}
