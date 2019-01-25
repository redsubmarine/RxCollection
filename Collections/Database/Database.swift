//
//  Database.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import Foundation
import class RxSwift.Observable
import class RxCocoa.BehaviorRelay

protocol Identify: Decodable {
    var id: String { get }
}

struct Id {
    typealias User = String
    typealias Issue = String
}

protocol IssueDatabase {
    func update(issue: Issue)
    func update(issues: [Issue])
    func observe(issueId: Id.Issue) -> Observable<Issue?>
    func issue(id: Id.Issue) -> Issue?
    func removeAllIssues()
}

protocol UserDatabase {
    func update(user: User)
    func observe(userId: Id.User) -> Observable<User?>
    func user(id: Id.User) -> User?
    func removeAllUsers()
}

class CoreDatabase {
    private let users = BehaviorRelay<[Id.User: User]>(value: [:])
    private let issues = BehaviorRelay<[Id.Issue: Issue]>(value: [:])
}

extension CoreDatabase: IssueDatabase {
    
    func update(issue: Issue) {
        var oldIssues = issues.value
        oldIssues[issue.id] = issue
        issues.accept(oldIssues)
    }
    
    func update(issues: [Issue]) {
        issues.forEach(update)
    }
    
    func observe(issueId: Id.Issue) -> Observable<Issue?> {
        return issues.asObservable()
            .map({ $0[issueId] })
    }
    
    func issue(id: Id.Issue) -> Issue? {
        return issues.value[id]
    }
    
    func removeAllIssues() {
        issues.accept([:])
    }
}

extension CoreDatabase: UserDatabase {

    func update(user: User) {
        var oldUsers = users.value
        oldUsers[user.id] = user
        users.accept(oldUsers)
    }
    
    func observe(userId: Id.User) -> Observable<User?> {
        return users.asObservable()
            .map({ $0[userId] })
    }
    
    func user(id: Id.User) -> User? {
        return users.value[id]
    }
    
    func removeAllUsers() {
        users.accept([:])
    }
}
