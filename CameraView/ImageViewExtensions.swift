//
//  ImageHandler.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/10/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

extension MapViewController {
    
    /// Populates the images array with all assets that have a location property.
    ///
    /// - note: This function should be called only *after* the assets array has been populated with all assets of type PHAssetMediaType.Image.
    func populateImageArray() {
        
        assets.enumerateObjectsUsingBlock({ object, index, stop in
            let asset = object as! PHAsset
            if let location = asset.location {
                // only create an Image object if the asset has a location property
                self.handleImageCreation(asset, location: location)
            }
        })
    }
    
    /// Handles the proccess of grabbing an image from the given asset and creating an Image object to append to the images array.
    /// - parameters:
    ///   - asset: A PHAsset to create the Image object from.
    ///   - locations: A CLLocation to use as the assets location.
    func handleImageCreation(asset: PHAsset, location: CLLocation) {
        
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.synchronous = true
        options.resizeMode = PHImageRequestOptionsResizeMode.Exact
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        
        let targetSize: CGSize = CGSize(width: 100, height: 100)
        let newSize: CGSize = CGSize(width: 75, height: 75)
        
        let initialImage: UIImage = getImageFromAsset(asset, size: targetSize, options: options)
        let editedImage: UIImage = resizeImage(initialImage, newSize: newSize)
        
        self.images.append(Image(date: asset.creationDate!, coordinate: location.coordinate, image: editedImage, asset: asset))
    }
    
    /// Adds Image objects to the map with the FBClusteringManager custom annotation add function
    func populateMapWithImages() { clusteringManager.addAnnotations(self.images) }
}