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
        
        //https://api.github.com/
        // /repos/firebase/firebase-ios-sdk/issues
        let server = Server(baseURL: "https://api.github.com")
        let request = GetIssuesRequest()
        _ = server.request(request)
            .take(1)
            .subscribe(onNext: { issues in
                
            })
    }
}
