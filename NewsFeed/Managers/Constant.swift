//
//  Constant.swift
//  NewsFeed
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import Foundation

// https://newsapi.org/v2/top-headlines?country=us&apiKey=ca6f65d63e7c45a3a87d411a2eb1d965

class Constant {
    fileprivate static let API_KEY = "ca6f65d63e7c45a3a87d411a2eb1d965"
    fileprivate static let pageSize = 20
    fileprivate static let baseURL = "https://newsapi.org/v2/"
    fileprivate static let defaultParams = "apiKey=\(API_KEY)&pageSize=\(pageSize)"
    
    
    static let searchURL = "\(Constant.baseURL)everything?\(defaultParams)"
    static let trandingURL = "\(Constant.baseURL)top-headlines?\(defaultParams)&country=us"
    
}
