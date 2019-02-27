//
//  NewsFeedTests.swift
//  NewsFeedTests
//
//  Created by Denis Kalashnikov on 2/26/19.
//  Copyright © 2019 Denis Kalashnikov. All rights reserved.
//

import XCTest
@testable import NewsFeed

class NewsFeedTests: XCTestCase {
    var model: NewsFeed?
    override func setUp() {
        if let url = Bundle.main.url(forResource: "TestModel", withExtension: "json"), let jsonData = try? Data(contentsOf: url){
            model = try? newJSONDecoder().decode(NewsFeed.self, from: jsonData)
        }
        
    }
    
    override func tearDown() {
        model = nil
    }
    
    func testModelHasLoaded() {
        XCTAssert(model != nil)
    }
    
    func testNumbersOfNewsLoaded()  {
        XCTAssert(model?.articles?.count ?? -1 > 0)
    }
    

}
