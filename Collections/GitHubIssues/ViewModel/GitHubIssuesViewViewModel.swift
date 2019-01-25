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
    private let issues = BehaviorRelay<[Id.Issue]>(value: [])
    
    init(server: Server, database: IssueDatabase) {
        self.server = server
        self.database = database
        
        dataSource = issues.asObservable()
            .map({ issues in
                [SectionData(id: "issues", items: issues.map({ issueId in
                    CellInfo(id: issueId, data: .issue(issueId: issueId), style: GitHubIssueCell.bundle())
                }))]
            })
    }
    
    func getIssues() {
        let request = GetIssuesRequest()
        _ = server.request(request)
            .take(1)
            .do(onNext: database.update)
            .map({ $0.map({ $0.id }) })
            .bind(to: issues)
    }
}
