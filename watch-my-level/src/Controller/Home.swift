//
//  Home.swift
//  watch-my-level
//
//  Created by DéjàLu on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class Home: UIViewController {

    @IBOutlet var BT_LOG: UIButton!
    @IBOutlet var IG_LOG: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    @IBAction func BT_GAME(_ sender: UIButton) {
        
        let ll = Loading()
        
        self.redirectTo(from: self, to: ll)
        
        if GameLevel.level < 4 {
            
            CardService.default.findByLevel(id: GameLevel.level) { (cards) in
                
                let to = GameLevel()
                
                to.cards = cards
                
                self.redirectTo(from: ll, to: to)
            }
            
        } else {
            
            UserService.default.findAll(complete: { (users) in
                
                let to = Ranking()
                
                to.users = users
                
                self.redirectTo(from: ll, to: to)
            })
        }
    }
    
    @IBAction func BT_IC_LOGIN(_ sender: UIButton) {
        
        self.redirectTo(from: self, to: Login())
    }
    
    @IBAction func BT_TX_CAT(_ sender: UIButton) {
        
        let ll = Loading()
        
        self.redirectTo(from: self, to: ll)
        
        ProductService.default.findAll { (products) in
            
            let to = Catalogue()
            
            to.products = products
            
            self.redirectTo(from: ll, to: to)
        }
    }
    
    @IBAction func BT_TX_AUT(_ sender: UIButton) {
        
        self.redirectTo(from: self, to: Login())
    }
}

// Menu Extension
extension Home {
    
    func initPanel() {
        
        let mm = MenuManager()
        
        let BT = mm.BT(view: self)
        
        BT.addTarget(self, action: #selector(openPanel), for: .touchUpInside)
    }
    
    @objc func openPanel() {
        
        let view: UIViewController = SideMenuManager.default.menuLeftNavigationController!
        
        present(view, animated: true, completion: nil)
    }
    
    func redirectTo(from: UIViewController, to: UIViewController) {
        
        let mm = MenuManager()
        
        mm.redirectTo(from: from, to: to)
    }
}

// Front Extension
extension Home {
    
    func initView() {
        
        self.initPanel()
        self.navigationItem.title = "Watch My Level"
        
        if let currentUser = ActiveManager.activeUser {
            
            self.BT_LOG.isHidden = true
            self.IG_LOG.isHidden = true
            
        } else {
            
            self.BT_LOG.isHidden = false
            self.IG_LOG.isHidden = false
        }
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
