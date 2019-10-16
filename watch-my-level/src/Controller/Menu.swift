//
//  Menu.swift
//  watch-my-level
//
//  Created by DéjàLu on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit

class Menu: UIViewController {

    @IBOutlet var BT_IG_logo: UIButton!
    
    @IBOutlet var BT_IC_001: UIButton!
    @IBOutlet var BT_IC_002: UIButton!
    @IBOutlet var BT_IC_003: UIButton!
    @IBOutlet var BT_IC_004: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initView()
    }

    func initView() {
        
        // >>> logo
        self.setImage(BT: self.BT_IG_logo, named: "augarde.png")
        
        // >>> icons
        self.setImage(BT: self.BT_IC_001, named: "game.png")
        self.setImage(BT: self.BT_IC_002, named: "calendar.png")
        self.setImage(BT: self.BT_IC_003, named: "about-us.png")
        self.setImage(BT: self.BT_IC_004, named: "logout.png")
    }
    
    func setImage(BT: UIButton, named: String) {
        
        let IG = UIImage(named: named) as UIImage?
        BT.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        BT.setImage(IG, for: .normal)
        BT.tintColor = UIColor.black
        BT.imageView?.contentMode = .scaleAspectFit
        BT.addTarget(self, action: "btnTouched:", for: .touchUpInside)
    }
}
