//
//  TappedHandler.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/21/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation


extension ImageViewController {
    
    /// Simulates a blackout of everything but the photo when the user taps.  
    ///
    /// If a blackout is already in effect when the image is tapped, return to normal state.
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        if self.view.backgroundColor == UIColor.whiteColor() {
            handleHide()
        } else {
            handleShow()
        }
    }
    
    /// Hides elements on the screen.
    func handleHide() {
        animateBackgroundColor(UIColor.blackColor())
        hideAnimateWithDuration(collectionView)
        hideAnimateWithDuration(toolbar)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// Shows elements on the screen.
    func handleShow() {
        animateBackgroundColor(UIColor.whiteColor())
        showAnimateWithDuration(collectionView)
        showAnimateWithDuration(toolbar)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// Animates the change in a background color.
    func animateBackgroundColor(backgroundColor: UIColor) {
        
        let options: UIViewAnimationOptions = [UIViewAnimationOptions.CurveEaseInOut]
        UIView.animateWithDuration(0.2, delay: 0, options: options, animations: {
            self.view.backgroundColor = backgroundColor
            }, completion: { finished in
                
        })
    }
    
    /// Animates the change from shown to hidden of a given view.
    /// - parameters:
    ///   - view: A UIView to hide.
    func hideAnimateWithDuration(view: UIView) {
        
        let options: UIViewAnimationOptions = [UIViewAnimationOptions.CurveEaseInOut]
        UIView.animateWithDuration(0.2, delay: 0, options: options, animations: {
            view.alpha = 0
            }, completion: { finished in
                view.hidden = true
        })
    }
    
    /// Animates the change from hidden to shown of a given view.
    /// - parameters:
    ///   - view: A UIView to show.
    func showAnimateWithDuration(view: UIView) {
        
        let options: UIViewAnimationOptions = [UIViewAnimationOptions.CurveEaseInOut]
        view.hidden = false
        UIView.animateWithDuration(0.2, delay: 0, options: options, animations: {
            view.alpha = 1
            }, completion: { finished in
        })
    }
}