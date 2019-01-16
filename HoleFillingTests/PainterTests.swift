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
    
    let fullRow: [Float] = [0.234,1,0.986,0.465,0.125]
    let holeRow: [Float] = [0.184, -1, -1, -1, 0.162]
    
    override func setUp() {
        let matrix = [fullRow, fullRow, holeRow, holeRow, holeRow, fullRow, fullRow]
        image = try! Image(matrix: matrix, pixelConnectivity: .four)
        calculator = try! WeightCalculator()
        painter = Painter(image: image, calculator: calculator)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExistence() {
        XCTAssertNotNil(painter)
    }
    
    func testPainter_ImageWithFilledHoles_ReturnsAnImageWithFilledHoles() {
        var pixelValue = self.image.pixel(at: (3, 2))?.value
        XCTAssertEqual(pixelValue, -1)
        
        let imageFilled = painter.imageWithFilledHoles()
        print(image)
        print()
        print(imageFilled)
        
        pixelValue = imageFilled.pixel(at: (3, 2))?.value
        XCTAssertNotEqual(pixelValue, -1)
    }

}
