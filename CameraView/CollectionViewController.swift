//
//  CollectionViewController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/11/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: Array<Image> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.collectionView!.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /* Handle segue to image view */
            
        let indexPath: Int = sender as! Int
        let imageViewController: ImageViewController = segue.destinationViewController as! ImageViewController
        let image: Image = images[indexPath]
        imageViewController.image = image
        imageViewController.imagesInCollection = images
        imageViewController.currentIndex = indexPath
    }

}
