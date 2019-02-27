//
//  NewsModel.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    var page: Int = 1
    var totalResults: Int = 0

    var articles = [Article]()
    var isLoading = false

    func shouldLoadNextPage(_ currentItemIndex:Int) -> Bool {
        if(!isLoading && currentItemIndex > (articles.count-5) && hasMore()) {
            return true
        }else{
            return false
        }
    }
    
    func reload(complition:@escaping ((Error?)->Void)) {
        page = 1
        articles.removeAll()
        loadPage(page, completion: complition)
    }
    
    func loadPage(_ page: Int, completion:@escaping ((Error?)->Void)) {
        isLoading = true
        NetworkManager.feed(page) { (newsModel, error) in
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
