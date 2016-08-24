//
//  ImageController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/22/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

extension ImageViewController {
    
    /// Loads the image to the view in high quality.
    func loadImageToView() {
        let imageToShow: UIImage = getFullImageFromAsset((image?.asset)!)
        imageView.image = imageToShow
        print(self.currentIndex!)
        print(self.collectionView)
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: currentIndex!, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        self.view.layoutIfNeeded()
    }
    
    /// Gets the highest quality image from an asset.
    /// - parameters:
    ///   - asset: The PHAsset to get the image from.
    func getFullImageFromAsset(asset: PHAsset) -> UIImage {
        
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.synchronous = true
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        
        return getImageFromAsset(asset, size: PHImageManagerMaximumSize, options: options)
    }
    
    /// Gets a thumbnail image from an asset
    /// - parameters:
    ///   - asset: The PHAsset to get the image from.
    func getThumbnailImageFromAsset(asset: PHAsset) -> UIImage {
        
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.synchronous = true
        options.resizeMode = PHImageRequestOptionsResizeMode.Exact
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        
        let size: CGSize = CGSize(width: 75, height: 90)
        
        return getImageFromAsset(asset, size: size, options: options)
    }
}