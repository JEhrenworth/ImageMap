//
//  CollectionController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/12/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

extension ImageViewController {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        /* Only ever one section in this collection view */
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /* Return the number of images in the collection as the number of cells */
        return (imagesInCollection?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        /* Populate the cells */
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
       
        let imageForItem: Image = imagesInCollection![indexPath.item]
        let imageView = UIImageView(image: getThumbnailImageFromAsset(imageForItem.asset))
        
        imageView.frame = cell.contentView.frame
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        cell.contentView.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        /* Handle the centering of the collection view, and the selection of a cell */
        
        self.currentIndex = indexPath.item
        let imageForItem: Image = imagesInCollection![indexPath.item]
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        self.view.layoutIfNeeded()
        imageView.image = getFullImageFromAsset(imageForItem.asset)
    }
}