//
//  ViewController.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 15/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        script()
    }

    func script() {
        // Create objects and dependencies
        let calculator = try! WeightCalculator()
        let painter = Painter(calculator: calculator)
        let filler = HoleFiller(painter: painter)

        let image = createRandomImage(width: 8, height: 8)
        print("---- ORIGINAL ----")
        print(image)
        print()
        
        let imageWithHoles = filler.addHoles(to: image)
        print("---- WITH HOLES ----")
        print(imageWithHoles)
        print()
        
        print("---- WITH FILLED HOLES ----")
        let imageWithFilledHoles = filler.fillHoles(in: imageWithHoles)
        print(imageWithFilledHoles)
        print()
    }

    func createRandomImage(width: Int, height: Int) -> Image {
        var array = [Float]()
        let total = (width*height)
        for _ in 0..<total {
            array.append(Float.random(in: 0...1))
        }
        let matrix = self.matrix(from: array, width: width)
        return try! Image(matrix: matrix, pixelConnectivity: .four)
    }
    
    private func matrix(from array: [Float], width: Int) -> [[Float]]{
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
        return matrix
    }
}




