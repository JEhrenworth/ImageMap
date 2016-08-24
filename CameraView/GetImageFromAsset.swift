//
//  GetImageFromAsset.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/21/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

/// Returns an image of specified size, retrieved with specified options, from an asset.
/// - parameters:
///   - asset: The PHAsset to get the image from.
///   - size: The CGSize to use when requesting the image.
///   - options: The PHImageRequestOptions to use when requesting the image.
func getImageFromAsset(asset: PHAsset, size: CGSize, options: PHImageRequestOptions) -> UIImage {
    var returnImage: UIImage = UIImage()
    
    PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: size, contentMode: PHImageContentMode.AspectFill, options: options) { (image, info) in
        returnImage = image!
    }; return returnImage
}