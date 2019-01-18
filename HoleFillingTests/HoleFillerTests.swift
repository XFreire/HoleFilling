//
//  HoleFillerTests.swift
//  HoleFillingTests
//
//  Created by Alexandre Freire on 17/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import HoleFilling

class HoleFillerTests: XCTestCase {

    var image: Image!
    var filler: HoleFiller!
    var imageWithHoles: Image!
    let column: [Float] = [0.1, 0.8, 0.3, 0.2]
    override func setUp() {
        let matrix = [ column, column, column, column ]
        image = try! Image(matrix: matrix, pixelConnectivity: .four)
        let painter = Painter()
        
        filler = HoleFiller(painter: painter)
        
        imageWithHoles = filler.addHoles(to: image)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHoleFiller_AddHoles() {
        let holes = imageWithHoles.findHoles()
        XCTAssertEqual(holes.count, 4)
    }
    
    func testHoleFiller_FillHoles() {
        print(image)
        let imageWithFilledHoles = filler.fillHoles(in: image)
        print(imageWithFilledHoles)
        let holes = imageWithFilledHoles.findHoles()

        XCTAssertTrue(holes.isEmpty)
        
    }

}
