//
//  Curriculum_Vitae_TestTests.swift
//  Curriculum Vitae TestTests
//
//  Created by Farouke Nnajiofor on 2019-10-21.
//  Copyright © 2019 Farouke Nnajiofor. All rights reserved.
//

import XCTest
@testable import Curriculum_Vitae_Test

class Curriculum_Vitae_TestTests: XCTestCase {

    func testParsingCV() {
        
        var testVitae : Vitae?
        var testErrorString : String?
        
        let parsingExpectation = expectation(description: "Parsing CV Data...")
        
        let asset = NSDataAsset.init(name: "dataset.json", bundle: Bundle(for: Curriculum_Vitae_TestTests.self))
        DataController.parseCVData(data: asset!.data,
                                   completionHandler: {vitae in
                                        testVitae = vitae
                                        parsingExpectation.fulfill()},
                                   errorHandler: {errorString in
                                        testErrorString = errorString
                                        parsingExpectation.fulfill()})
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual("Farouk Uzoma Nnajiofor", testVitae?.name)
        XCTAssertEqual(nil, testErrorString)
        
    }

}
