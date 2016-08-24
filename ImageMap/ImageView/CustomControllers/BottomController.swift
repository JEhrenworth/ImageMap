//
//  BottomCollectionController.swift
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
    
    @IBAction func trashButtonPressed(sender: UIBarButtonItem) {
        let arrayToDelete: NSArray = NSArray(object: imagesInCollection![currentIndex!].asset)
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ PHAssetChangeRequest.deleteAssets(arrayToDelete) }) { (deleteSelected, error) in
            if deleteSelected {
                self.handleDeletion()
            }
        }
    }
    
    /// Handles the deletion of a photo by changing the collection view, and the image view.
    func handleDeletion() {
        
        if (self.imagesInCollection?.count)! - 1 > 0 {
            handleMove(findIndexToChangeTo())
        } else {
            dispatch_async(dispatch_get_main_queue(), {
              self.performSegueWithIdentifier("ToMapViewFromImageView", sender: UIButton())
            })
        }
    }
    
    /// Finds a valid index to change to.
    /// - note: Call after you've checked is the number of images in the collection view - 1 is greater than zero (in other words, there will be a valid index after we delete the element.
    func findIndexToChangeTo() -> Int {
        
        var indexToChangeTo: Int = Int()
        if self.currentIndex! == (self.imagesInCollection?.count)! - 1 {
            indexToChangeTo = 0
        } else {
            indexToChangeTo = self.currentIndex!
        }; return indexToChangeTo
    }
    
    /// Changes the collection view and the image view to accomadate the deletion.
    /// - parameters:
    ///   - indexToChangeTo: the Int to use as the index when changing the views
    func handleMove(indexToChangeTo: Int) {
        
        dispatch_async(dispatch_get_main_queue(), {
            self.imagesInCollection?.removeAtIndex(self.currentIndex!)
            self.collectionView.deleteItemsAtIndexPaths([NSIndexPath(forItem: self.currentIndex!, inSection: 0)])
            
            self.imageView.image = self.getFullImageFromAsset(self.imagesInCollection![indexToChangeTo].asset)
            
            self.currentIndex = indexToChangeTo
            
            self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: self.currentIndex!, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func shareButtonPressed(sender: UIBarButtonItem) {
        shareContent()
    }
    
    /// Pulls up the UIActivityViewController with the share items option.
    func shareContent() {
        
        let imageToShare: UIImage = getFullImageFromAsset(imagesInCollection![currentIndex!].asset)
        let shareItems: NSArray = ["", imageToShare]
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: shareItems as [AnyObject], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    /// Handles left swipe.
    @IBAction func leftGestureSwiped(sender: UISwipeGestureRecognizer) {
        
        currentIndex! -= 1
        if currentIndex < 0 {
            currentIndex = (self.imagesInCollection?.count)! - 1
        }; self.imageView.image = getFullImageFromAsset(self.imagesInCollection![currentIndex!].asset)
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: currentIndex!, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        self.view.layoutIfNeeded()
    }
    
    /// Handles right swipe.
    @IBAction func rightGestureSwiped(sender: UISwipeGestureRecognizer) {
        
        currentIndex! += 1
        if currentIndex == imagesInCollection?.count {
            currentIndex = 0
        }; self.imageView.image = getFullImageFromAsset(imagesInCollection![currentIndex!].asset)
        
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: currentIndex!, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        self.view.layoutIfNeeded()
    }
}