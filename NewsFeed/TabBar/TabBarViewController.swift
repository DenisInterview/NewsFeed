//
//  TabBarViewController.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newsVC = UIStoryboard(name: "NewsTableViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewsTableViewController")
        let searchVC = UIStoryboard(name: "SearchTableViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchTableViewController")
        newsVC.title = "News"
        searchVC.title = "Search"
        viewControllers = [newsVC, searchVC]
    }
    
}

