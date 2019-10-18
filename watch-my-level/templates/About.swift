//
//  About.swift
//  watch-my-level
//
//  Created by Viviana Montiel on 17/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class About: UIViewController {

    @IBOutlet var TX_DESCRIPTION: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.initAll()
    }
}


// Default Extension
extension About {
    
    func initAll() {
        
        self.navigationItem.title = "About US"
        
        self.initPanel()
        
        self.TX_DESCRIPTION.isUserInteractionEnabled = false
        
    }
}

// Menu Extension
extension About {
    
    func initPanel() {
        
        let mm = MenuManager()
        
        let BT = mm.BT(view: self)
        
        BT.addTarget(self, action: #selector(openPanel), for: .touchUpInside)
    }
    
    func redirectTo(from: UIViewController, to: UIViewController) {
        
        let mm = MenuManager()
        
        mm.redirectTo(from: from, to: to)
    }
    
    @objc func openPanel() {
        
        let view: UIViewController = SideMenuManager.default.menuLeftNavigationController!
        
        present(view, animated: true, completion: nil)
    }
}
