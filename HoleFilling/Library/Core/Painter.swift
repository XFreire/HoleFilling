//
//  Painter.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 16/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

final class Painter {
    
    // MARK: Properties
    private let calculator: WeightCalculator
    private let image: Image
    
    private var holes: Pixels
    private var borders: Pixels
    
    // MARK: Initialization
    init(image: Image, calculator: WeightCalculator = try! WeightCalculator()) {
        self.image = image
        self.calculator = calculator
        
        holes = self.image.findHoles()
        borders = self.image.findHoleBorders()
    }
    
//    func fillHoles() -> Image {
//        let filledHoles = holes.map { $0.value = calculateColor(of: $0) }
//        let image = self.image.clone(adding: filledHoles)
//        return image 
//    }
    
    func calculateColor(of holePixel: Pixel) -> Float {
        var numerator: Float = 0
        var denominator: Float = 0
        
        for pixel in borders {
            let weight = calculator.weight(holePixel, pixel)
            numerator = numerator + (weight * pixel.value)
            denominator = denominator + weight
        }
        
        return numerator / denominator
    }
}
