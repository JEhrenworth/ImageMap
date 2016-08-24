//
//  CustomOverlayView.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/9/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit

/// Provides a link to the overlay view.
///
/// Can be used to set the overlay on top of the camera picker, like so:
///
///     customView = customViewController.view as! CustomOverlayView
///     customView.frame = self.picker.view.frame
///
///     customView.frame.origin.y = 0
///
///     self.presentViewController(picker, animated: true, completion: {self.picker.cameraOverlayView = self.customView})
class CustomOverlayView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
