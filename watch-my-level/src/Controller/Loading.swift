//
//  Loading.swift
//  watch-my-level
//
//  Created by DéjàLu on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit

class Loading: UIViewController {

    @IBOutlet var load: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
        initAnimation()
    }
    
    func initNavigation() {
        
        // Title
        self.navigationItem.title = "Chargement..."
        
        // Left Button
        self.navigationItem.hidesBackButton = true
    }
    
    func initAnimation() {
        
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 2;
        rotationAnimation.isCumulative = true;
        rotationAnimation.repeatCount = .infinity;
        
        self.load.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
