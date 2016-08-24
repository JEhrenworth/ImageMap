//
//  Image.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/10/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation


/// The image class provides the infrastructure for managing a captured asset of type PHAssetMediaType.Image as an MKAnnotation.
///
/// This class is almost never subclassed, but instances are often created.
///
/// When an image object is created:
///
///     // anAsset in this example is an asset of type PHAssetMediaType.Image
///     // and imageFetchedFromAnAsset is a UIImage fetched using PHImageManager.defaultManager().requestImageForAsset()
///     let myImageObject: Image = Image(date: anAsset.creationDate!, coordinate: anAsset.location.coordinate, image: imageFetchedFromAnAsset, asset: anAsset)
/// it can be added directly to a map as an annotation. For example:
///
///     // mapView is a reference to MKMapView
///     mapView.addAnnotation(myImageObject)
///
/// - parameters:
///   - date: An NSDate object to attach to the Image object.  Image.shortDate, and Image.shortTime string properties are created from this parameter.
///   - coordinate: A CLLocationCoordinate2D object to attach to the Image object. **When the Image object is added to the map as an annotation, coordinate specifies where it will be added to.**
///   - image: A UIImage to attach to the Image object.  If you are never going to need a new UIImage from the asset this can make a large performance difference (instead of requesting a new UIImage from the asset, refer to this property).
///   - asset: A PHAssetMediaType.Image asset to attach to the Image object.  If you need to request a new UIImage use this property to get the asset.
class Image: NSObject, MKAnnotation {
    
    let title: String?
    let date: NSDate
    let shortDate: String
    let shortTime: String
    let coordinate: CLLocationCoordinate2D
    let image: UIImage
    let asset: PHAsset
    
    init(date: NSDate, coordinate: CLLocationCoordinate2D, image: UIImage, asset: PHAsset) {
        self.title = String()
        self.date = date
        self.shortDate = date.toLongDateString()
        self.shortTime = date.toShortTimeString()
        self.coordinate = coordinate
        self.image = image
        self.asset = asset
        
        super.init()
    }
}



