//
//  Pixel.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 15/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

typealias Coordinates = (x: Int, y: Int)
struct Pixel {
    let x: Int
    let y: Int
    var value: Float
}

extension Pixel {
    init(coordinates: Coordinates, value: Float) {
        self.x = coordinates.x
        self.y = coordinates.y
        self.value = value
    }
}

extension Pixel {
    var proxy: String {
        return "\(x) \(y)"
    }
}
extension Pixel: Hashable, Equatable {
    static func == (lhs: Pixel, rhs: Pixel) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}
