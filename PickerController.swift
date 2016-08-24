//
//  PickerController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/9/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    
    /// Sets up picker with options and adds custom views.
    ///
    /// - note: Must be called after picker has been initialized.
    func setUpPicker() {
        self.picker.delegate = self
        self.picker.allowsEditing = false
        self.picker.sourceType = UIImagePickerControllerSourceType.Camera
        self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo
        self.picker.showsCameraControls = true
        
        customView = customViewController.view as! CustomOverlayView
        customView.frame = self.picker.view.frame
        
        customView.frame.origin.y = 0
        
        self.presentViewController(picker, animated: true, completion: {self.picker.cameraOverlayView = self.customView})
    }

    /// Handles saving of image and reseting of picker.
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil)
        self.picker.dismissViewControllerAnimated(true, completion: {self.manageMainView()})
    }
}