//
//  CGImage+pixelValues.swift
//  HoleFilling
//
//  Created by Alexandre Freire on 15/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import CoreGraphics
//
//extension CGImage {
//    func pixelValues() -> (pixelValues: [UInt8]?, width: Int, height: Int)
//    {
//        var width = 0
//        var height = 0
//        var pixelValues: [UInt8]?
//        width = self.width
//        height = self.height
//        let bitsPerComponent = self.bitsPerComponent
//        let bytesPerRow = self.bytesPerRow
//        let totalBytes = height * bytesPerRow
//
//        let colorSpace = CGColorSpaceCreateDeviceGray()
//        var intensities = [UInt8](repeating: 0, count: totalBytes)
//
//        let contextRef = CGContext(data: &intensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: 0)
//        contextRef?.draw(self, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
//
//        pixelValues = intensities
//
//
//        return (pixelValues, width, height)
//    }
//}
//
//func image(fromPixelValues pixelValues: [UInt8]?, width: Int, height: Int) -> CGImage?
//{
//    var imageRef: CGImage?
//    if var pixelValues = pixelValues {
//        let bitsPerComponent = 8
//        let bytesPerPixel = 1
//        let bitsPerPixel = bytesPerPixel * bitsPerComponent
//        let bytesPerRow = bytesPerPixel * width
//        let totalBytes = height * bytesPerRow
//
//        imageRef = withUnsafePointer(to: &pixelValues, {
//            ptr -> CGImage? in
//            var imageRef: CGImage?
//            let colorSpaceRef = CGColorSpaceCreateDeviceGray()
//            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).union(CGBitmapInfo())
//            let data = UnsafeRawPointer(ptr.pointee).assumingMemoryBound(to: UInt8.self)
//            let releaseData: CGDataProviderReleaseDataCallback = {
//                (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> () in
//            }
//
//            if let providerRef = CGDataProvider(dataInfo: nil, data: data, size: totalBytes, releaseData: releaseData) {
//                imageRef = CGImage(width: width,
//                                   height: height,
//                                   bitsPerComponent: bitsPerComponent,
//                                   bitsPerPixel: bitsPerPixel,
//                                   bytesPerRow: bytesPerRow,
//                                   space: colorSpaceRef,
//                                   bitmapInfo: bitmapInfo,
//                                   provider: providerRef,
//                                   decode: nil,
//                                   shouldInterpolate: false,
//                                   intent: CGColorRenderingIntent.defaultIntent)
//            }
//
//            return imageRef
//        })
//    }
//
//    return imageRef
//}

func pixelValues(fromCGImage imageRef: CGImage?) -> (pixelValues: [UInt8]?, width: Int, height: Int)
{
    var width = 0
    var height = 0
    var pixelValues: [UInt8]?
    if let imageRef = imageRef {
        width = imageRef.width
        height = imageRef.height
        let bitsPerComponent = imageRef.bitsPerComponent
        let bytesPerRow = imageRef.bytesPerRow
        let totalBytes = height * bytesPerRow
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        var intensities = [UInt8](repeating: 0, count: totalBytes)
        
        let contextRef = CGContext(data: &intensities, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: 0)
        contextRef?.draw(imageRef, in: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(height)))
        
        pixelValues = intensities
    }
    
    return (pixelValues, width, height)
}

func image(fromPixelValues pixelValues: [UInt8]?, width: Int, height: Int) -> CGImage?
{
    var imageRef: CGImage?
    if var pixelValues = pixelValues {
        let bitsPerComponent = 8
        let bytesPerPixel = 1
        let bitsPerPixel = bytesPerPixel * bitsPerComponent
        let bytesPerRow = bytesPerPixel * width
        let totalBytes = height * bytesPerRow
        
        imageRef = withUnsafePointer(to: &pixelValues, {
            ptr -> CGImage? in
            var imageRef: CGImage?
            let colorSpaceRef = CGColorSpaceCreateDeviceGray()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue).union(CGBitmapInfo())
            let data = UnsafeRawPointer(ptr.pointee).assumingMemoryBound(to: UInt8.self)
            let releaseData: CGDataProviderReleaseDataCallback = {
                (info: UnsafeMutableRawPointer?, data: UnsafeRawPointer, size: Int) -> () in
            }
            
            if let providerRef = CGDataProvider(dataInfo: nil, data: data, size: totalBytes, releaseData: releaseData) {
                imageRef = CGImage(width: width,
                                   height: height,
                                   bitsPerComponent: bitsPerComponent,
                                   bitsPerPixel: bitsPerPixel,
                                   bytesPerRow: bytesPerRow,
                                   space: colorSpaceRef,
                                   bitmapInfo: bitmapInfo,
                                   provider: providerRef,
                                   decode: nil,
                                   shouldInterpolate: false,
                                   intent: CGColorRenderingIntent.defaultIntent)
            }
            
            return imageRef
        })
    }
    
    return imageRef
}
