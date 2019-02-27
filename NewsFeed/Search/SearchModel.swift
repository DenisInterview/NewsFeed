//
//  SearchModel.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit

class SearchModel: NSObject {
    var page: Int = 1
    var totalResults: Int = 0
    var searchText = ""
    var articles = [Article]()
    var isLoading = false
    
    func shouldLoadNextPage(_ currentItemIndex:Int) -> Bool {
        if(!isLoading && currentItemIndex > (articles.count-5) && hasMore()) {
            return true
        }else{
            return false
        }
    }
    
    func clear()  {
        articles.removeAll()
        page = 1
    }
    func search(_ text: String, completion:@escaping ((Error?)->Void))  {
        searchText = text
        clear()
        loadPage(1, completion: completion)
    }
    
    func loadPage(_ page: Int, completion:@escaping ((Error?)->Void)) {
        isLoading = true
        NetworkManager.search(searchText, page: page) { (newsModel, error) in
            self.isLoading = false
            guard let newsModel = newsModel else{
                completion(error)
                return
            }
            if let total = newsModel.totalResults{
                self.totalResults = total
            }
            self.articles.append(contentsOf: newsModel.articles ?? [])
            completion(nil)
        }
    }
    func hasMore() -> Bool {
        return articles.count < totalResults
    }
    
    func loadNextPage(completion:@escaping ((Error?)->Void)) {
        if hasMore() {
            page += 1
            loadPage(page, completion: completion)
        }
    }
}
