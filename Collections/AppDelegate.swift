//
//  AppDelegate.swift
//  Collections
//
//  Created by 양원석 on 06/11/2018.
//  Copyright © 2018 red. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let server = Server()
        let issuesViewModel = GitHubIssuesViewViewModel(server: server, database: publicDB)
        let issuesViewController = GitHubIssuesViewController.newInstance(with: issuesViewModel)
        
        window?.rootViewController = issuesViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

let publicDB = CoreDatabase()
