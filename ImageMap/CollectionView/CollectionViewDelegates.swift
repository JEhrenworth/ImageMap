//
//  CollectionViewDelegates.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/11/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//
import UIKit
import MapKit
import Photos
import CoreLocation


extension CollectionViewController {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        /* Only ever one section in the collection view */
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /* Return number of images as the number of items */
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /* Populate the collection view cells with images */

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        let imageForItem: Image = images[indexPath.item]
        
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.synchronous = true
        options.resizeMode = PHImageRequestOptionsResizeMode.Fast
        options.deliveryMode = PHImageRequestOptionsDeliveryMode.HighQualityFormat
        
        let imageView = UIImageView(
            image: getImageFromAsset(imageForItem.asset, size: CGSize(width: 150, height: 150), options: options)
        )
        imageView.frame = cell.contentView.frame
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        /* When a cell is selected segue to image view */
        self.performSegueWithIdentifier("ToImageView", sender: indexPath.item)
    }

}