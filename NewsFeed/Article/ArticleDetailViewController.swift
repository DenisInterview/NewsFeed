//
//  ArticleDetailViewController.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    public var url : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
