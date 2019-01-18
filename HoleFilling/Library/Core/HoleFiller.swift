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

    // MARK: Properties
    private let painter: PainterProtocol
    
    // MARK: Initialization
    init(painter: PainterProtocol) {
        self.painter = painter
    }
    
    func addHoles(to image: Image) -> Image {
        return painter.addHoles(to: image)
    }
    
    func fillHoles(in image: Image) -> Image {
        return painter.fillHoles(to: image)
    }
}
