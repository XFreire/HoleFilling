//
//  Painter.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 16/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol PainterProtocol {
    func addHoles(to: Image) -> Image
    func fillHoles(to: Image) -> Image
}

final class Painter: PainterProtocol {
    
    // MARK: Properties
    private let calculator: WeightCalculator
    private var image: Image? {
        didSet {
            guard let image = image else { return }
            borders = image.findHoleBorders()
        }
    }
    
    //private var holes: Pixels
    private var borders: Pixels?
    
    // MARK: Initialization
    init(calculator: WeightCalculator = try! WeightCalculator()) {
        
        self.calculator = calculator
        
        //holes = self.image.findHoles()
        
    }
    
    func fillHoles(to image: Image) -> Image {
        self.image = image
        var imageCopy = image // Image is value type so it is copied
        let holes = imageCopy.findHoles()
        holes.forEach { imageCopy.change($0, with: calculateColor(of: $0)) }
        
        return imageCopy
    }
    
    func addHoles(to image: Image) -> Image {
        var theImage = image
        let width = image.width
        let height = image.height
        
        for i in (width/4)..<(3*width/4) {
            for j in (height/4)..<(3*height/4) {
                if let pixel = theImage.pixel(at: (i, j))  {
                    theImage.change(pixel, with: -1)
                }
            }
        }
        
        self.image = image
        
        return theImage
    }
    
    private func calculateColor(of holePixel: Pixel) -> Float {
        var numerator: Float = 0
        var denominator: Float = 0
        
        for pixel in borders! {
            let weight = calculator.weight(holePixel, pixel)
            numerator = numerator + (weight * pixel.value)
            denominator = denominator + weight
        }
        
        return numerator / denominator
    }
}
