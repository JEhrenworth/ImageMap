//
//  OverlayController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/9/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import Foundation

extension MainViewController {
    
    /// Handles the overlay on the picker default camera.
    func handleOverlay() {
        /* Remove the overlay when the user takes a picture and segues to the use/retake screen.  If user clicks retake, add the overlay back on. */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(removeCameraOverlay), name: "_UIImagePickerControllerUserDidCaptureItem", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(addCameraOverlay), name: "_UIImagePickerControllerUserDidRejectItem", object: nil)
    }
    
    /// Removes observers from NSNotificationCenter once we are done with them.
    func removePhotoObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /// Adds overlay on top of picker.
    func addCameraOverlay() {
        self.picker.cameraOverlayView = self.customView
    }
    
    /// Removes overlay on top of picker.
    func removeCameraOverlay() {
        self.picker.cameraOverlayView = nil
    }
}