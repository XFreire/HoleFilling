//
//  ImageTests.swift
//  HoleFillingTests
//
//  Created by Alexandre Freire on 15/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import XCTest
@testable import HoleFilling

class ImageTests: XCTestCase {

    var image: Image!
    let fullRow: [Float] = [1,1,1,1,1]
    let holeRow: [Float] = [1, -1, -1, -1, 1]
    
    override func setUp() {
        
        let matrix = [fullRow, fullRow, holeRow, holeRow, holeRow, fullRow, fullRow]
        image = try! Image(matrix: matrix, pixelConnectivity: .four)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageExistence() {
        XCTAssertNotNil(image)
    }
    
    func testImage_WhenValidValues_ReturnsIsValidTrue() {
        XCTAssertTrue(image.isValid)
    }
    
    func testImage_WhenInvalidValues_ReturnsIsValidFalse() {
        let matrix = [fullRow, fullRow, [2, 1, 1, 0.5, 1], holeRow, holeRow, fullRow]
        let image = try! Image(matrix: matrix, pixelConnectivity: .four)
        XCTAssertFalse(image.isValid)
    }
    
    func testImage_PixelAt_ReturnsTheCorrectPixel() {
        var pixel = image.pixel(at: (2, 2))
        
        XCTAssertEqual(pixel, Pixel(x: 2, y: 2, value: -1))
        
        pixel = image.pixel(at: (-2, 2))
        XCTAssertNil(pixel)
        
        pixel = image.pixel(at: (7, 2))
        XCTAssertNil(pixel)
    }
    
    func testImage_IsHolePixel() {
        var pixel = image.pixel(at: (0,0))!
        XCTAssertFalse(image.isHole(pixel))
        
        pixel = image.pixel(at: (2,2))!
        XCTAssertTrue(image.isHole(pixel))
        
        pixel = image.pixel(at: (2,3))!
        XCTAssertTrue(image.isHole(pixel))
        
        pixel = image.pixel(at: (2,4))!
        XCTAssertFalse(image.isHole(pixel))
    }
    
    func testImage_FindPixelHoleNeighbors_ReturnsTheCorrectSetOfPixels() {
        var pixel = image.pixel(at: (0,0))!
        var neighbors = image.findPixelHoleNeighbors(of: pixel)

        XCTAssertEqual(neighbors.count, 0)
        
        pixel = image.pixel(at: (1,0))!
        neighbors = image.findPixelHoleNeighbors(of: pixel)
        
        XCTAssertEqual(neighbors.count, 1)
        
        pixel = image.pixel(at: (3,2))!
        neighbors = image.findPixelHoleNeighbors(of: pixel)
        
        XCTAssertEqual(neighbors.count, 4)
    }
    
    func testImage_IsBorderPixel() {
        var pixel = image.pixel(at: (1, 1))!
        XCTAssertTrue(image.isBorderPixel(pixel))
        
        pixel = image.pixel(at: (1, 0))!
        XCTAssertTrue(image.isBorderPixel(pixel))
        
        pixel = image.pixel(at: (1, 2))!
        XCTAssertTrue(image.isBorderPixel(pixel))
        
        pixel = image.pixel(at: (3, 0))!
        XCTAssertTrue(image.isBorderPixel(pixel))
        
        pixel = image.pixel(at: (5, 2))!
        XCTAssertTrue(image.isBorderPixel(pixel))
        
        pixel = image.pixel(at: (3, 4))!
        XCTAssertTrue(image.isBorderPixel(pixel))
        
        pixel = image.pixel(at: (0, 0))!
        XCTAssertFalse(image.isBorderPixel(pixel))
        
        pixel = image.pixel(at: (6, 0))!
        XCTAssertFalse(image.isBorderPixel(pixel))
    }
    
    func testImage_FindHoleBorders() {
        let holeBorders = image.findHoleBorders()
        
        XCTAssertEqual(holeBorders.count, 16)
    }
    
    func testImage_FindHoles() {
        let holes = image.findHoles()
        
        XCTAssertEqual(holes.count, 9)
    }
    
    func testImage_CreateThroughArray() {
        let array: [Float] = [1,2,3,4,5,6,7,8,9, 10, 11, 12]
        let width = 3
        let height = 4
        var matrix = [[Float]]()
        for _ in 0..<width {
            matrix.append([])
        }
        
        let sequence = stride(from: 0, to: array.count, by: width)
        for i in 0..<width {
            for j in sequence {
                matrix[i].append(array[i+j])
            }
        }
        let img = try! Image(matrix: matrix, pixelConnectivity: .four)
    
        print(img)
        XCTAssertTrue(true)
    }
}
