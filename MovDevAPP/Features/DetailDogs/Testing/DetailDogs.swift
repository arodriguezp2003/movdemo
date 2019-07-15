//
//  DetailDogs.swift
//  MovDevAPPTests
//
//  Created by Alejandro  Rodriguez on 7/15/19.
//  Copyright © 2019 Tech. All rights reserved.
//

import XCTest
@testable import MovDevAPP
import OHHTTPStubs
class DetailDogs: XCTestCase {

    lazy var model: DetailDogModel =  {
        let m = DetailDogModel(DogEntity(name: "Akira"))
        m.delegate = self
        m.service = DetailDogService()
        return m
    }()
    var requestExpectation: XCTestExpectation?
    
    override func setUp() {
       requestExpectation = expectation(description: "Go")
    }

    override func tearDown() {}

    func test_getImageList_SUCCESS_200() {
        let jsonObject = ["message": ["img1", "img2", "img3"]]
        call_getImageList(statusCode: 200, jsonObject: jsonObject)
        XCTAssertEqual(requestExpectation?.expectationDescription, "OK")
    }
    
    func test_getImageList_ERROR_500() {
        let jsonObject = ["message": ["img1", "img2", "img3"]]
        call_getImageList(statusCode: 500, jsonObject: jsonObject)
        XCTAssertEqual(requestExpectation?.expectationDescription, "NO")
    }
}

extension DetailDogs: DogImageModelDelegate {
    func updateData() {
        let data = self.model.images!
        
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

extension DetailDogs {
    
    
    func call_getImageList(statusCode: Int32, jsonObject: Any) {
        setResponseService(endPoint: model.service!.URL(At: "filter"), statusCode: statusCode, jsonObject: jsonObject)
        model.getImageList()
        wait(for: [requestExpectation!], timeout: 100)
    }
    func setResponseService(endPoint:String,statusCode:Int32,jsonObject:Any){
        let host = ConfigAPP.API.replacingOccurrences(of: "/api", with: "").replacingOccurrences(of: "https://", with: "")
        stub(condition: isHost(host)) { _ in
            return OHHTTPStubsResponse(jsonObject: jsonObject, statusCode: statusCode, headers: nil)
        }
    }
}
