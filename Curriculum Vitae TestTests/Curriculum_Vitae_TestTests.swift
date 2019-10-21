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

    func testFetchingCV() {
        let url = URL(string: cvDataUrlString)!
        fetchCVData(url: url, completionHandler: {vitae in
            XCTAssertEqual("Farouk Uzoma Nanjiofor", vitae.name)
        }, errorHandler: {_ in })
    }

}
