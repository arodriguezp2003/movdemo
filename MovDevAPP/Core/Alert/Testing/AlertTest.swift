//
//  AlertTest.swift
//  MovDevAPPTests
//
//  Created by Alejandro  Rodriguez on 7/15/19.
//  Copyright © 2019 Tech. All rights reserved.
//

import XCTest
@testable import MovDevAPP

class AlertTest: XCTestCase {

    let title = "Ocurrio un error"
    let subtitle = "el motivo"
    
    override func setUp() {}

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AlerRetry() {
        let vc = AlertRetryFactory().getAlertRetryViewController(title: title, subtitle: subtitle)
        let _title = vc.presenter?.dataStore?.title == title
        let _subtitle = vc.presenter?.dataStore?.subtitle == subtitle
        
        XCTAssert(_title)
        XCTAssert(_subtitle)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
