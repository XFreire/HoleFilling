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
    let value: Float
}

extension Pixel {
    init(coordinates: Coordinates, value: Float) {
        self.x = coordinates.x
        self.y = coordinates.y
        self.value = value
    }
}
extension Pixel: Hashable, Equatable {}
