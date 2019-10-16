//
//  Home.swift
//  watch-my-level
//
//  Created by DéjàLu on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet var BT_IC_LEFT: UIButton!
    
    @IBOutlet var BT_IC_RIGHT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
}

extension Home {
    
    func initView() {
        
        // ST Front
        self.setImage(BT: self.BT_IC_LEFT)
        self.setImage(BT: self.BT_IC_RIGHT)
        applyShadow(BT: BT_IC_LEFT)
        applyShadow(BT: BT_IC_RIGHT)
    }
    
    func setImage(BT: UIButton) {
        
        BT.imageView?.contentMode = .scaleAspectFit
        
    }
    
    func applyShadow(BT: UIButton){
        BT.layer.shadowColor = UIColor.black.cgColor
        BT.layer.shadowOffset = CGSize(width: 10, height: 10)
        BT.layer.shadowRadius = 5
        BT.layer.shadowOpacity = 3.0
    }
}
