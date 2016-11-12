//
//  SurveysAppTests.swift
//  SurveysAppTests
//
//  Created by NSMohamedElalfy on 11/7/16.
//  Copyright © 2016 NSMohamedElalfy. All rights reserved.
//

import XCTest
@testable import SurveysApp

class SurveysAppTests: XCTestCase {
    
    var mainVC:MainViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        mainVC = nav.topViewController as! MainViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadingResource(){

        let resource = Resource<[Survey]>(url: API.baseURL , parameters: ["access_token" : API.accessToken], parseJSON: { json in
            guard let dictionaries = json as? [JSONDictionary] else { return nil }
            return dictionaries.flatMap(Survey.init)
        })
        
        let expectation = self.expectation(description: "Asynchronous Request")
        Webservice.shared.load(resource: resource) { result in
            if let res = result.value {
                XCTAssertNotNil(res , "No Retriving Data")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 30.0 , handler:{ error in
            Webservice.shared.cancelAllLoadingTasks()
            NSLog("Test timed out")
        })
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        let date = Date()
        
        self.measure {
            let string = dateFormatter.string(from: date)
            NSLog(string)
        }
    }
    
}
