//
//  GitHubIssuesViewController.swift
//  Collections
//
//  Created by 양원석 on 24/01/2019.
//  Copyright © 2019 red. All rights reserved.
//

import UIKit

class GitHubIssuesViewController: UIViewController {

    class func newInstance(with viewModel: GitHubIssuesViewViewModel) -> GitHubIssuesViewController {
        let vc = GitHubIssuesViewController(nibName: "GitHubIssuesViewController", bundle: nil)
        vc.viewModel = viewModel
        return vc
    }
    
    private (set) var viewModel: GitHubIssuesViewViewModel!
    private let collectionController = CollectionController.newInstance(type: .tableView)
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionController.bind(to: tableView, source: viewModel.dataSource)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.getIssues()
    }
}
