//
//  ImageRezise.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/10/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import Foundation
import UIKit

/// Returns an image resized to the size specified in newSize.
/// - parameters:
///   - image: A UIImage to resize.
///   - newSize: A CGSize to to resize to.
/// - returns: A new UIImage of size newSize.
func resizeImage(image: UIImage, newSize: CGSize) -> (UIImage) {
    
    // without this a call to resizeImage of CGSize(75, 75) returns an image twice the size of the requested image so scale down the requested size by two to get the return image to actually be the requested image size.
    let size: CGSize = CGSize(width: newSize.width / 2, height: newSize.height / 2)
    
    let newRect = CGRectIntegral(CGRectMake(0,0, size.width, size.height))
    let imageRef = image.CGImage
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let context = UIGraphicsGetCurrentContext()
    
    CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
    let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, size.height)
    
    CGContextConcatCTM(context, flipVertical)
    CGContextDrawImage(context, newRect, imageRef)
    
    let newImageRef = CGBitmapContextCreateImage(context)! as CGImage
    let newImage = UIImage(CGImage: newImageRef)
    
    UIGraphicsEndImageContext()
    
    return newImage
}
