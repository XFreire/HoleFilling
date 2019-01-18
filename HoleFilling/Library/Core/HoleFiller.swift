//
//  HoleFiller.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 17/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

protocol HoleFillerProtocol {
    func fillHoles(in image: Image) -> Image
    func addHoles(to image: Image) -> Image
}

final class HoleFiller: HoleFillerProtocol {

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
        
        return theImage
    }
    
    func fillHoles(in image: Image) -> Image {
        let painter = Painter(image: image)
        return painter.imageWithFilledHoles()
    }
}
