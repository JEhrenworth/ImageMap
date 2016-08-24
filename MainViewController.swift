//
//  MainViewController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/9/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MapViewControllerDelegate {
    
    var didPresentCamera = false
    
    var picker: UIImagePickerController = UIImagePickerController.init()
    
    lazy var customViewController: CustomOverlayViewController = {
        return CustomOverlayViewController(viewController: self)
    }()
    var customView: CustomOverlayView = CustomOverlayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        /* Needed to stop a bug where the retake/use photo screen doesn't go away after user clicks use photo */
        if didPresentCamera == false {
            didPresentCamera = true
            manageMainView()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToMapView" {
            let destinationViewController: MapViewController = segue.destinationViewController as! MapViewController
            destinationViewController.delegate = self
        }
    }
    
    /// Dismisses the picker and inits a segue.
    func performSegue(sender: AnyObject?) {
        self.picker.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("ToMapView", sender: sender)
    }
    
    /// Resets the didPresentCamera option to false.
    func setDidPresentCameraToFalse() {
        self.didPresentCamera = false
    }
    
    /// Performs sanity checks and handles appropriately
    func manageMainView() {
        if cameraIsInaccessible() {
            createAndShowCameraAlert()
        } else {
            setUpPicker()
            handleOverlay()
        }
    }

    /// Returns true when the camera on the phone **can't** be accessed, for one reason or another.
    func cameraIsInaccessible() -> Bool {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            return true
        }; return false
    }
    
    /// Handles the alert when the camera is inaccessible.
    func createAndShowCameraAlert() {
        
        let alertController = UIAlertController(title: "No Camera Accesible", message: "This app can't access the devices camera.  A camera is needed to run this app.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let OKAction = UIAlertAction(title: "Return to Homescreen", style: UIAlertActionStyle.Default) { (action) in
            // exit the app
            UIControl().sendAction(#selector(NSURLSessionTask.suspend), to: UIApplication.sharedApplication(), forEvent: nil)
            alertController.resignFirstResponder()
        }; alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}