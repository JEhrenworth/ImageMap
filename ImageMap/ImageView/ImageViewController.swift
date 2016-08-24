//
//  ImageViewController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/11/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

class ImageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    var imagesInCollection: Array<Image>? = nil
    var image: Image? = nil
    var currentIndex: Int? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        loadImageToView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if parent == nil {
            /* Back button was pressed in nav bar */
            if self.previousViewController()!.isKindOfClass(CollectionViewController) {
                let collectionViewController: CollectionViewController = self.previousViewController() as! CollectionViewController
                collectionViewController.images = imagesInCollection!
            }
        }
    }
}
