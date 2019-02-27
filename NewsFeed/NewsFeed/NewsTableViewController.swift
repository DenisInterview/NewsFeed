//
//  NewsTableViewController.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    let model = NewsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: NewsTableViewCell.id, bundle: Bundle.main), forCellReuseIdentifier: NewsTableViewCell.id)
        
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        refresh()
        
        let refereshControlView = UIRefreshControl()
        refereshControlView.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refereshControlView
        
    }
    
    @objc func refresh() {
        tableView.refreshControl?.beginRefreshing()
        model.reload() { error in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.articles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.id, for: indexPath) as! NewsTableViewCell
        cell.setup(model: model.articles[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(model.shouldLoadNextPage(indexPath.row)){
            model.loadNextPage { error in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = model.articles[indexPath.row].url {
            let detailVC = UIStoryboard.init(name: "ArticleDetailViewController", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
            detailVC.url = URL(string: url)
            detailVC.title = model.articles[indexPath.row].title
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }


}
