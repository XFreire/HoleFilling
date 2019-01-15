//
//  PixelTests.swift
//  HoleFillingTests
//
//  Created by Alexandre Freire on 15/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import HoleFilling

class PixelTests: XCTestCase {

    var pixel: Pixel!
    
    override func setUp() {
        pixel = Pixel(x: 1, y: 1, value: 0.8)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPixelExistence() {
        XCTAssertNotNil(pixel)
        
        let other = Pixel(coordinates: (1,1), value: 1)
        XCTAssertNotNil(other)
    }
    
    func testPixelHashable() {
        XCTAssertNotNil(pixel.hashValue)
    }
    
    func testPixelComparison() {
        let other = Pixel(x: 1, y: 1, value: 0.8)
        XCTAssertTrue(pixel == other)
    }
}
