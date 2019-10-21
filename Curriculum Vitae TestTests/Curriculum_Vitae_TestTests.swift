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
        let asset = NSDataAsset(name: "dataset.json")
        DataController.parseCVData(data: asset!.data,
                                   completionHandler: {vitae in
                                        XCTAssertEqual("Farouk Uzoma Nnajiofor", vitae.name)},
                                   errorHandler: {_ in })
    }

}
