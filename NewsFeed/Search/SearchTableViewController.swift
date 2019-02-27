//
//  SearchTableViewController.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    @IBOutlet weak var footerView: UIView!
    
    let model = SearchModel()
    let searchController = UISearchController(searchResultsController: nil)
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: NewsTableViewCell.id, bundle: Bundle.main), forCellReuseIdentifier: NewsTableViewCell.id)
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Setup search controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.setValue("Cancel", forKey: "_cancelButtonText")
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        footerView.isHidden = model.articles.count != 0
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

extension SearchTableViewController: UISearchBarDelegate{
    func filterContentForSearchText(_ searchText: String){
        self.searchText = searchText
        model.search(searchText) { (error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
        model.clear()
        tableView.reloadData()
    }
}

extension SearchTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    
}

