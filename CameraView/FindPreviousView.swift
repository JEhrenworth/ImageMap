//
//  FindPreviousViewController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/22/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

extension UIViewController {
    
    /// Returns the previous view controller in a navigation controller stack of view controller.
    ///
    /// If no stack is present returns nil.
    func previousViewController() -> UIViewController? {
        if let stack = self.navigationController?.viewControllers {
            for i in (1..<stack.count).reverse() {
                if(stack[i] == self) {
                    return stack[i-1]
                }
            }
        }; return nil
    }
}