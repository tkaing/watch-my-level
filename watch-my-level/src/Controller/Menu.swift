//
//  Menu.swift
//  watch-my-level
//
//  Created by DéjàLu on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class Menu: UIViewController {

    @IBOutlet var BT_IG_SYM: UIButton!
    @IBOutlet var BT_IC_001: UIButton!
    @IBOutlet var BT_IC_002: UIButton!
    @IBOutlet var BT_IC_003: UIButton!
    @IBOutlet var BT_IC_005: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    // Menu Redirection
    @IBAction func BT_IG_SYM(_ sender: UIButton) {
        
        self.redirectTo(from: self, to: Home())
    }
    @IBAction func BT_TX_001(_ sender: UIButton) {
        
        let ll = Loading()
        
        self.redirectTo(from: self, to: ll)
        
        GameLevel.level = 1
        
        CardService.default.findByLevel(id: GameLevel.level) { (cards) in
            
            let to = GameLevel()
            
            to.cards = cards
            
            self.redirectTo(from: ll, to: to)
        }
    }
    @IBAction func BT_TX_002(_ sender: UIButton) {
        
        let lo = Loading()
        
        self.redirectTo(from: self, to: lo)
        
        EventService.default.findAll { (events) in
            
            let to = Events()
            
            to.events = events
            
            self.redirectTo(from: lo, to: to)
        }
    }
    @IBAction func BT_TX_003(_ sender: UIButton) {
        
        let lo = Loading()
        
        self.redirectTo(from: self, to: lo)
        
        EventService.default.findAll { (items) in
            
            self.redirectTo(from: lo, to: About())
        }
    }
    @IBAction func BT_TX_CAT(_ sender: UIButton) {
        
        let lo = Loading()
        
        self.redirectTo(from: self, to: lo)
        
        ProductService.default.findAll { (products) in
            
            let to = Catalogue()
            
            to.products = products
            
            self.redirectTo(from: lo, to: to)
        }
    }
    
    
}

// Menu Extension
extension Menu {
    
    func redirectTo(from: UIViewController, to: UIViewController) {
        
        let mm = MenuManager()
        
        mm.redirectTo(from: from, to: to)
    }
}

// Front Extension
extension Menu {
    
    func initView() {
        
        // ST Front
        self.setImage(BT: self.BT_IG_SYM)
        self.setImage(BT: self.BT_IC_001)
        self.setImage(BT: self.BT_IC_002)
        self.setImage(BT: self.BT_IC_003)
        //self.setImage(BT: self.BT_IC_004)
        self.setImage(BT: self.BT_IC_005)
    }
    
    func setImage(BT: UIButton) {
        
        BT.imageView?.contentMode = .scaleAspectFit
    }
}
