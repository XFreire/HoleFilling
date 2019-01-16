//
//  PainterTests.swift
//  HoleFillingTests
//
//  Created by Alexandre Freire on 16/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import HoleFilling

class PainterTests: XCTestCase {

    var image: Image!
    var calculator: WeightCalculator!
    var painter: Painter!
    
    let fullRow: [Float] = [1,1,1,1,1]
    let holeRow: [Float] = [1, -1, -1, -1, 1]
    
    override func setUp() {
        let matrix = [fullRow, fullRow, holeRow, holeRow, holeRow, fullRow, fullRow]
        image = try! Image(matrix: matrix, pixelConnectivity: .four)
        calculator = WeightCalculator()
        painter = Painter(image: image, calculator: calculator)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExistence() {
        XCTAssertNotNil(painter)
    }
    
//    func testPainter_FillHoles_ReturnsAnImageWithFilledHoles() {
//        let image = painter.fillHoles()
//    }

}
