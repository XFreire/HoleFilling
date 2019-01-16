//
//  WeightCalculatorTests.swift
//  HoleFillingTests
//
//  Created by Alexandre Freire on 16/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import HoleFilling

class WeightCalculatorTests: XCTestCase {

    var calculator: WeightCalculator!
    var u: Pixel!
    var v: Pixel!
    
    override func setUp() {
        calculator = try! WeightCalculator()
        u = Pixel(x: 0, y: 0, value: 10)
        v = Pixel(x: 2, y: 2, value: 10)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWiightCalculatorExistence() {
        XCTAssertNotNil(calculator)
    }
    
    func testWeightCalculator_Weight() {
        let distance = calculator.weight(u, v)
        
        XCTAssertEqual(distance, 1 / (8 + 0.001), accuracy: 0.0000001)
    }

}
