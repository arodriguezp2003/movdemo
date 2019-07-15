//
//  DogsTest.swift
//  MovDevAPPTests
//
//  Created by Alejandro  Rodriguez on 7/15/19.
//  Copyright © 2019 Tech. All rights reserved.
//

import XCTest
@testable import MovDevAPP
import OHHTTPStubs

class DogsTest: XCTestCase {

    
    lazy var model: DogsModel =  {
        let m = DogsModel()
        m.delegate = self
        m.service = DogsService()
        return m
    }()
    
    var requestExpectation: XCTestExpectation?
    
    
    override func setUp() {
        requestExpectation = expectation(description: "Go")
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getList_SUCCESS_200() {
        let jsonObject = ["message": ["b1", "b2", "b3"]]
        call_getDogList(statusCode: 200, jsonObject: jsonObject)
        XCTAssertEqual(requestExpectation?.expectationDescription, "OK")
    }
    
    func test_getList_ERROR_500() {
        let jsonObject = ["message": ["b1", "b2", "b3"]]
        call_getDogList(statusCode: 500, jsonObject: jsonObject)
        XCTAssertEqual(requestExpectation?.expectationDescription, "NO")
    }
}

extension DogsTest: DogsModelDelegate {
    func updateData() {
        let data = self.model.dogs
        
        if data.count == 3 {
            requestExpectation?.expectationDescription = "OK"
            requestExpectation?.fulfill()
            return
        }
        requestExpectation?.expectationDescription = "NO"
        requestExpectation?.fulfill()
    }
    func errorData(_ message: String) {
        requestExpectation?.expectationDescription = "NO"
        requestExpectation?.fulfill()
    }
}

extension DogsTest {

    
    func call_getDogList(statusCode: Int32, jsonObject: Any) {
        
        setResponseService(endPoint: model.service!.URL, statusCode: statusCode, jsonObject: jsonObject)
        
        model.getDogList()
        
        wait(for: [requestExpectation!], timeout: 100)
    }
    
    //MARK: - Config Service
    
    func setResponseService(endPoint:String,statusCode:Int32,jsonObject:Any){
        let host = ConfigAPP.API.replacingOccurrences(of: "/api", with: "").replacingOccurrences(of: "https://", with: "")
        stub(condition: isHost(host)) { _ in
            return OHHTTPStubsResponse(jsonObject: jsonObject, statusCode: statusCode, headers: nil)
        }
    }
}
