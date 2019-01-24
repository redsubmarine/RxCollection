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
    enum IssueStyle {
        case new
        case normal
    }
    
    class func bundle(style: IssueStyle) -> CellStyleBundle<IssueStyle> {
        return CellStyleBundle(type: self, parameters: style)
    }
    
    static var nibName: String? = "GitHubIssueCell"
    
    static var reuseIdentifier: String = "GitHubIssueCell"
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var presenter: UIViewController?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func apply(cellInfo: CellInfo) {
        if let style = cellInfo.style as? CellStyleBundle<IssueStyle> {
            if let param = style.parameters {
                switch param {
                case .new:
                    contentView.backgroundColor = .red
                    print(" 11")
                case .normal:
                    contentView.backgroundColor = .blue
                    print(" 22")
                }
            }
        }
    }
    
    static func cellHeight(info: CellInfo) -> CGFloat {
        return 44.0
    }
    
}
