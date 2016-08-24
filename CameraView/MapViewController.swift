//
//  MapViewController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/10/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation

protocol MapViewControllerDelegate {
    func setDidPresentCameraToFalse()
}

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var clusteringManager: FBClusteringManager = FBClusteringManager()
    
    var locationManager = CLLocationManager()
    var assets: PHFetchResult = PHFetchResult()
    var images: Array<Image> = []
    var delegate: MapViewControllerDelegate?
    let initialRadius: Double = 5000
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.delegate = self
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.assets = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        self.images = []
        self.clusteringManager = FBClusteringManager()
        manageMapViewLoad()
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        
        self.delegate?.setDidPresentCameraToFalse()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /* Set appropriate properties deppending on where the segue is pointing */
        
        if segue.identifier == "ToCollectionController" {
            /* Set collection view images array to the annotations attached to the cluster */
            /* This segue should only happen when a cluster was tapped on the map */
            let collectionViewController: CollectionViewController = segue.destinationViewController as! CollectionViewController
            let cluster: FBAnnotationCluster = sender as! FBAnnotationCluster
            let annotations: Array<Image> = cluster.annotations as! Array<Image>
            
            collectionViewController.images = annotations
        } else {
            /* Set image view properties */
            /* This segue should only happen when an unclustered image is tapped on the map */
            let imageViewController: ImageViewController = segue.destinationViewController as! ImageViewController
            let selectedImage: Image = sender as! Image
            
            imageViewController.image = selectedImage
            imageViewController.imagesInCollection = [selectedImage]
            imageViewController.currentIndex = 0
        }
    }
    
    /// Manages the behavior of map view.
    ///
    /// Call this function as soon as the map loads to set up the CLLocationManager, center the map, populate the images array, and add the images to the map.
    /// - note: Call this function after having set the CLLocationManager.delegate to self (i.e. `myLocationManager.delegate = self`).
    func manageMapViewLoad() {
        
        setLocationManagerOptions()
        centerMapOnLocation(userCurrentLocation(locationManager), raduis: initialRadius)
        populateImageArray()
        populateMapWithImages()
    }
    
    /// Sets up the CLLocationManager options.
    /// - note: Call after having set the CLLocationManager.delegate to self (i.e. `myLocationManager.delegate = self`).
    func setLocationManagerOptions() {
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.startUpdatingLocation()
    }

    /// Gets user location from the location manager passed in.
    ///
    /// - note: If location services are not enabled returns the CLLocation of downtown New York City.
    /// - parameters: 
    ///   - locationManager: A CLLocationManger object to derive location and permission from.
    /// - returns: The location property of locationManager passed in, or CLLocation of downtown New York City.
    func userCurrentLocation(locationManager: CLLocationManager) -> CLLocation {
        
        if (CLLocationManager.locationServicesEnabled()) {
            if let location: CLLocation = locationManager.location {
                return location
            }
        }; return CLLocation(latitude: 40.728964, longitude: -73.997984)
    }
    
    /// Centers the MKMapView on the a location passed in.
    /// - parameters:
    ///   - location: A CLLocation to center on.
    ///   - radius: A Double to set as the radius of the view.
    func centerMapOnLocation(location: CLLocation, raduis: Double) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, raduis, raduis)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}

