//
//  Image.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 15/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

typealias Pixels = Set<Pixel>

enum PixelConnectivity: Int {
    case four = 4
    case eight = 8
}

typealias ImageMatrix = [[Float]]

enum ImageError: Error {
    case invalidImage
}

struct Image {
    
    // MARK: Properties
    let width: Int
    let height: Int
    private let pixelConnectivity: PixelConnectivity
    private var matrix: ImageMatrix
    
    // MARK: Initialization
    init(matrix: ImageMatrix, pixelConnectivity: PixelConnectivity) throws {
        guard let height = matrix.first?.count else { throw ImageError.invalidImage }

        self.width = matrix.count
        self.height = height
        self.matrix = matrix
        self.pixelConnectivity = pixelConnectivity
        
        guard height > 0 && width > 0 else { throw ImageError.invalidImage }
    }
    
    var isValid: Bool {
        for i in 0..<width {
            for j in 0..<height {
                let value = matrix[i][j]
                let range = MIN_VALID_VALUE...MAX_VALID_VALUE
                if !range.contains(value) && value != -1 {
                    return false
                }
            }
        }
        return true
    }
    
    func pixel(at coordinates: Coordinates) -> Pixel? {
        let x = coordinates.x
        let y = coordinates.y
        
        guard x >= 0 && x < width && y >= 0 && y < height else {
            return nil
        }
        
        return Pixel(x: x, y: y, value: matrix[x][y])
    }
    
    func isHole(_ pixel: Pixel) -> Bool {
        return pixel.value == HOLE_VALUE
    }
    
    func findPixelHoleNeighbors(of pixel: Pixel) -> Pixels {
        var holeNeighbors = Set<Pixel>()
        
        let x = pixel.x
        let y = pixel.y
        
        for i in -1...1 {
            for j in -1...1 {
                if ((i == 0 && j == 0) || ((i == 0 || j == 0) && pixelConnectivity == .four) ||
                    x+i<0 || y+j<0 || x+i >= width || y+j >= height){
                    continue
                }
                
                if let thePixel = self.pixel(at: (x+i, y+j)),
                    isHole(thePixel) {
                    holeNeighbors.insert(thePixel)
                }
            }
        }
        
        return holeNeighbors
    }
    
    func isBorderPixel(_ pixel: Pixel) -> Bool {
        let x = pixel.x
        let y = pixel.y
        return matrix[x][y] != HOLE_VALUE && !findPixelHoleNeighbors(of: pixel).isEmpty
    }
    
    func findHoleBorders() -> Pixels {
        var borders = Pixels()
        for i in 0..<width {
            for j in 0..<height {
                let pixel = self.pixel(at: (i, j))
                if let pixel = pixel, isBorderPixel(pixel) {
                    borders.insert(pixel)
                }
            }
        }
        
        return borders
    }
    
    func findHoles() -> Pixels {
        var holes = Pixels()
        for i in 0..<width {
            for j in 0..<height {
                let pixel = self.pixel(at: (i, j))
                if let pixel = pixel, isHole(pixel) {
                    holes.insert(pixel)
                }
            }
        }
        
        return holes
    }
    
    mutating func change(_ pixel: Pixel, with value: Float) {
        let x = pixel.x
        let y = pixel.y
        
        matrix[x][y] = value
    }
}

extension Image: CustomStringConvertible {
    var description: String {
        var string = ""
        for j in 0..<height {
            string += "\n"
            for i in 0..<width {
                //string += String(format: "%2f", matrix[i][j])
                string += "  \(matrix[i][j])"
            }
        }
        
        return string
    }
}
