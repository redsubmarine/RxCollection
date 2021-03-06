//
//  GitHubIssueCell.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import UIKit
import class RxSwift.DisposeBag

class GitHubIssueCell: UITableViewCell, Cell {
    
    class func bundle() -> CellStyleBundle<Void> {
        return CellStyleBundle(type: self)
    }
    
    static var nibName: String? = "GitHubIssueCell"
    
    static var reuseIdentifier: String = "GitHubIssueCell"
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var presenter: UIViewController?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func apply(cellInfo: CellInfo) {
        guard case let .issue(issueId) = cellInfo.data else {
            fatalError()
        }
        
        publicDB.observe(issueId: issueId)
            .map({ $0?.title })
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        publicDB.observe(issueId: issueId)
            .map({ $0?.owner })
            .bind(to: ownerLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    static func cellHeight(info: CellInfo) -> CGFloat {
        return 60.0
    }
    
}
