//
//  NetworkManager.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import UIKit
import Alamofire

enum NetworkError: Error {
    case network
    case unknown
}

class NetworkManager: NSObject {
    static func search(_ searchText:String, page: Int, completion:@escaping ((NewsFeed?, Error?)->Void)) {
        let searchUrl = "\(Constant.searchURL)&page=\(page)&q=\(searchText)"
        if let url = URL(string: searchUrl) {
            Alamofire.request(url).responseNewsFeed { response in
                if let model = response.result.value {
                    print("page \(String(describing: model.articles?.count))")
                    completion(model, nil)
                }else if response.error != nil{
                    completion(nil, response.error)
                }else{
                    completion(nil, NetworkError.unknown)
                }
            }
        }else{
            completion(nil, NetworkError.unknown)
        }
    }
    
    static func feed(_ page: Int, completion:@escaping ((NewsFeed?, Error?)->Void)) {
        if let url = URL(string: "\(Constant.trandingURL)&page=\(page)") {
            Alamofire.request(url).responseNewsFeed { response in
                if let model = response.result.value {
                    print("page \(String(describing: model.articles?.count))")
                    completion(model, nil)
                }else if response.error != nil{
                    completion(nil, response.error)
                }else{
                    completion(nil, NetworkError.unknown)
                }
            }
        }else{
            completion(nil, NetworkError.unknown)
        }
    }
}
