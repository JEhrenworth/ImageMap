//
//  MapViewAddAnnotation.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/10/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        /* Updates clusters when the region is changed */
        
        /* Update the clusters */
        NSOperationQueue().addOperationWithBlock({
            let mapBoundsWidth: Double = Double(self.mapView.bounds.size.width)
            let mapRectWidth: Double = self.mapView.visibleMapRect.size.width
            
            let scale: Double = mapBoundsWidth / mapRectWidth
            
            let annotationArray: Array<MKAnnotation> = self.clusteringManager.clusteredAnnotationsWithinMapRect(self.mapView.visibleMapRect, withZoomScale: scale)
            
            self.clusteringManager.displayAnnotations(annotationArray, onMapView: self.mapView)
        })
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        /* Creates clusters and pins */
        
        var reuseId = ""
        
        if annotation.isKindOfClass(FBAnnotationCluster) {
            reuseId = "Cluster"
            
            // get cluster view from map view
            var clusterView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            let clusterAnnotation: FBAnnotationCluster = annotation as! FBAnnotationCluster
            let imageAnnotations: Array<Image> = clusterAnnotation.annotations as! Array<Image>
            let imageToUseAsClusterImage: UIImage = imageAnnotations[0].image
            
            let options: FBAnnotationClusterViewOptions = FBAnnotationClusterViewOptions(smallClusterImage: imageToUseAsClusterImage, mediumClusterImage: imageToUseAsClusterImage, largeClusterImage: imageToUseAsClusterImage)
            
            clusterView = FBAnnotationClusterView(annotation: annotation, reuseIdentifier: reuseId, options: options)
            return clusterView
        } else {
            reuseId = "Pin"
            
            // get pin view from map view
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            
            if pinView != nil {
                /* pinView already created; no need to recreate it, just change the annotation */
                pinView!.annotation = annotation
            } else {
                /* Create new pinView */
                let imageAnnotation: Image = annotation as! Image
                let image: UIImage = imageAnnotation.image
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.image = image
            }; return pinView
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        /* Segues to appropriate viewcontroller */
        
        if view.annotation!.isKindOfClass(FBAnnotationCluster) {
            self.performSegueWithIdentifier("ToCollectionController", sender: view.annotation)
        } else {
            /* Only one image, so segue straight to the image view */
            self.performSegueWithIdentifier("ToImageViewFromMap", sender: view.annotation)
        }
    }
}