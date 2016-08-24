//
//  CustomOverlayViewController.swift
//  CameraView
//
//  Created by Jackson Ehrenworth 18 on 8/9/16.
//  Copyright © 2016 Jackson Ehrenworth. All rights reserved.
//

import UIKit

class CustomOverlayViewController: UIViewController {
    
    let mainViewController: MainViewController
    
    /// Allows CustomOverlayViewController to be inited with a view controller to perform a segue to.
    init(viewController: MainViewController) {
        self.mainViewController = viewController
        super.init(nibName: "CustomOverlayViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /// Segues when the user presses the image button on the lower left
    @IBAction func imageButtonPressed(sender: UIButton) {
        
        mainViewController.performSegue(sender)
    }
}
