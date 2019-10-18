//
//  CatalogueProductDetail.swift
//  watch-my-level
//
//  Created by Viviana Montiel on 18/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class CatalogueProductDetail: UIViewController {

    @IBOutlet var productTitle: UILabel!
    @IBOutlet var productDescription: UITextView!
    @IBOutlet var productPrice: UITextView!
    
    public var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initAll()
    }
    
    func initAll() {
        
        self.navigationItem.title = "Détails de la montre"
        
        self.initPanel()
        
        if let currentProduct = self.product {
            self.productTitle.text = currentProduct.label
            self.productPrice.text = String(currentProduct.price) + " €"
            self.productDescription.text = currentProduct.description
        }
    }
}


// Menu Extension
extension CatalogueProductDetail {
    
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
