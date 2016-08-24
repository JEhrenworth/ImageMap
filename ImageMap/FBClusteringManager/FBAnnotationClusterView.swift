//
//  FBAnnotationClusterView.swift
//  FBAnnotationClusteringSwift
//
//  Created by Robert Chen on 4/2/15.
//  Copyright (c) 2015 Robert Chen. All rights reserved.
//  Located at https://github.com/ribl/FBAnnotationClusteringSwift

import Foundation
import MapKit

public class FBAnnotationClusterView : MKAnnotationView {
    
    var count = 0
    
    var fontSize:CGFloat = 12
    
    var imageName = "clusterSmall"
    
    var clusterImage: UIImage?
    
    var loadExternalImage : Bool = false
    
    var borderWidth:CGFloat = 3
    
    var countLabel:UILabel? = nil
    
    //var option : FBAnnotationClusterViewOptions? = nil
    
    public init(annotation: MKAnnotation?, reuseIdentifier: String?, options: FBAnnotationClusterViewOptions?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let cluster:FBAnnotationCluster = annotation as! FBAnnotationCluster
        count = cluster.annotations.count
        
        // change the size of the cluster image based on number of stories
        switch count {
        case 0...5:
            fontSize = 16
            if (options != nil) {
                loadExternalImage=true;
                clusterImage = (options?.smallClusterImage)!
            }
            else {
                imageName = "clusterSmall"
            }
            borderWidth = 3
            
        case 6...15:
            fontSize = 16
            if (options != nil) {
                loadExternalImage=true;
                clusterImage = (options?.mediumClusterImage)!
            }
            else {
                imageName = "clusterMedium"
            }
            borderWidth = 4
            
        default:
            fontSize = 16
            if (options != nil) {
                loadExternalImage=true;
                clusterImage = (options?.largeClusterImage)!
            }
            else {
                imageName = "clusterLarge"
            }
            borderWidth = 5
            
        }
        
        backgroundColor = UIColor.clearColor()
        setupLabel()
        setTheCount(count)
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLabel(){
        countLabel = UILabel(frame: bounds)
        
        if let countLabel = countLabel {
            countLabel.tag = 5
            countLabel.textAlignment = .Center
            countLabel.backgroundColor = UIColor.blueColor()
            countLabel.textColor = UIColor.whiteColor()
            countLabel.adjustsFontSizeToFitWidth = true
            countLabel.minimumScaleFactor = 2
            countLabel.numberOfLines = 1
            countLabel.font = UIFont(name: "Helvetica Neue Light", size: 12)
            countLabel.baselineAdjustment = .AlignCenters
            addSubview(countLabel)
        }
        
    }
    
    func setTheCount(localCount:Int){
        count = localCount;
        
        countLabel?.text = "\(localCount)"
        setNeedsLayout()
    }
    
    override public func layoutSubviews() {
        
        // Images are faster than using drawRect:
        
        let imageAsset = clusterImage
    
        image = imageAsset
        
        countLabel?.frame = CGRectMake(self.bounds.size.width, 0, 20, 20)
        let maximumLabelSize = CGSizeMake(30, 23);
        let expectedSize = countLabel?.sizeThatFits(maximumLabelSize)
        let width = expectedSize!.width * 1.5
        let height = expectedSize!.height * 1.1
        
        if height < width {
            countLabel?.frame = CGRectMake(countLabel!.frame.origin.x, countLabel!.frame.origin.y, width, height)
        } else {
            countLabel?.frame = CGRectMake(countLabel!.frame.origin.x, countLabel!.frame.origin.y, height, height)
        }
        
        countLabel?.center = CGPointMake(self.bounds.size.width, 0)
        countLabel?.layer.cornerRadius = height / 2
        countLabel?.layer.masksToBounds = true
    }
}

public class FBAnnotationClusterViewOptions : NSObject {
    var smallClusterImage : UIImage
    var mediumClusterImage : UIImage
    var largeClusterImage : UIImage
    
   
    public init (smallClusterImage : UIImage, mediumClusterImage : UIImage, largeClusterImage : UIImage) {
        self.smallClusterImage = smallClusterImage;
        self.mediumClusterImage = mediumClusterImage;
        self.largeClusterImage = largeClusterImage;
    }
    
}