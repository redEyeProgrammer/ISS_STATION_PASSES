//
//  ISS_Space_AppTests.swift
//  ISS_Space_AppTests
//
//  Created by redEyeProgrammer on 12/13/17.
//  Copyright © 2017 redEye. All rights reserved.
//

import XCTest
@testable import ISS_Space_App

class ISS_Space_AppTests: XCTestCase {
    
    var sessionUnderTest: URLSession!

    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }
    
    func testValidCallToiTunesGetsHTTPStatusCode200() {
        // given Stubbed Long and Lat
        let url = URL(string: "http://api.open-notify.org/iss-pass.json?lat=40.76268&lon=73.97855")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
