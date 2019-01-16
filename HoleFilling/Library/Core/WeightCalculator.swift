//
//  WeightCalculator.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 16/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

enum WeightCalculatorError: Error {
    case wrongWeightInput
}

final class WeightCalculator {
    
    // MARK: Properties
    private let epsilon: Float
    private let z: Int
    
    // MARK: Initialization
    init(z: Int = 2, epsilon: Float = 0.001) throws {
        if z < 0 || epsilon < 0 {
            throw WeightCalculatorError.wrongWeightInput
        }
        
        self.z = z
        self.epsilon = epsilon
    }
    
    func weight(_ u: Pixel, _ v: Pixel) -> Float {
        
        //let distance = sqrt(powf(Float(v.y - u.y), 2) + powf(Float(v.x - u.x), 2))
        let squareDistance = powf((Float(u.y - v.y)), 2) + powf((Float(u.x - v.x)), 2)
        let distance = sqrtf(squareDistance)
        let divisor = powf(distance, Float(z))  + epsilon
        return 1 / divisor
    }
}
