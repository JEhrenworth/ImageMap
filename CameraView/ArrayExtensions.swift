//
//  ArrayExtensions.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/11/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import Foundation

extension Array {
    
    /// Returns a random element from an Array.
    /// - returns: A random element from an array.  **Note** that this function returns the actual element, not an index.
    func randomElement() -> Element {
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}