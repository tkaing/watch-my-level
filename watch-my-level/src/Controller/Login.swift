//
//  Login.swift
//  watch-my-level
//
//  Created by Viviana Montiel on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class Login: UIViewController {
    
    @IBOutlet var WG_USERNAME: UITextField!
    @IBOutlet var WG_PASSWORD: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    @IBAction func BT_SUBMIT(_ sender: UIButton) {
        
        guard
            let USERNAME = self.WG_USERNAME.text,
            let PASSWORD = self.WG_PASSWORD.text
            else { return }
        
        if self.formValidation(username: USERNAME, password: PASSWORD) {
            
            let lo = Loading()
            
            self.redirectTo(from: self, to: lo)
            
            let parameters = [
                "username": USERNAME,
                "password": PASSWORD
            ]
            
            UserService.default.authenticate(data: parameters) { (item) in
                
                if let user = item {
                    
                    let to = Home()
                    
                    self.redirectTo(from: lo, to: to)
                    
                    ActiveManager.activeUser = user
                    
                    self.alert(title: "Connexion réussie", message: "Bienvenue chez Augarde : \(user.username) !")
                    
                } else {
                    
                    let to = Login()
                    
                    self.redirectTo(from: lo, to: to)
                    
                    self.alert(title: "Échec lors de la connexion", message: "Oups ! Les identifiants semblent incorrect")
                }
            }
            
        } else {
            
            self.alert(title: "Échec lors de la connexion", message: "Le formulaire est n'est pas valide")
        }
    }
}

// Menu Extension
extension Login {
    
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

// Form Extension
extension Login {
    
    func formValidation(username: String, password: String) -> Bool {
        
        return username != "" && password != ""
    }
    
    func alert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// Front Extension
extension Login {
    
    func initView() {
        
        // ST Menu
        self.initPanel()
        self.navigationItem.title = "Login"
    }
}
