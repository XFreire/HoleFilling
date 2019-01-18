//
//  ViewController.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 15/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let conversor = GrayScaleImageConversor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originalImage =  UIImage(named: "Food_4.JPG")!
        let imageResized = originalImage.resizeImage(newWidth: 200)
    
        let noirImage = imageResized.noir!
        print(" \(noirImage.size.width) x \(noirImage.size.height)")
     
        let pixels = noirImage.pixelData()
        print(pixels?.count)
        let imgView = UIImageView(frame: view.frame)
        imgView.contentMode = .scaleAspectFit
        imgView.image = noirImage
        view.addSubview(imgView)
        
        let cgImage = image(fromPixelValues: pixels, width: Int(noirImage.size.width), height: Int(noirImage.size.height))!
        print("Height \(cgImage.height)")
        print("Width \(cgImage.width)")
        imgView.image = UIImage(cgImage: cgImage)
        
        //let pixels = pixelValues(fromCGImage: noirImage.cgImage!)
        
//        print("\(200*150) == \(pixels.pixelValues?.count)")
//        print("Height \(pixels.height)")
//        print("Width \(pixels.width)")
        
//        let mat = matrix(from: pixels.pixelValues!, width: pixels.width)
//        print(mat[0].count)
        
//        let cgImage = image(fromPixelValues: pixels.pixelValues, width: pixels.width, height: pixels.height)!
//        print("Height \(cgImage.height)")
//        print("Width \(cgImage.width)")
        //imgView.image = UIImage(cgImage: cgImage)
        
        
        //pixels?.pixelValues.forEach{ print($0) }
        
//        let pixels = image.pixelValues()
//
//        pixels.pixelValues?.forEach { print($0) }
    }


}

func matrix(from array: [UInt8], width: Int) -> [[UInt8]]{
    var matrix = [[UInt8]]()
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
