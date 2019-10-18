//
//  Catalogue.swift
//  watch-my-level
//
//  Created by Viviana Montiel on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class Catalogue: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    public var products: [Product] = []
    
    public var cellID = "PRODUCT_CELL_ID"
    
    override func viewDidLoad() {
        
        self.table.delegate = self
        self.table.dataSource = self
        self.table.register(UINib(nibName: "CatalogueTableViewCell", bundle: nil), forCellReuseIdentifier: self.cellID)
        
        super.viewDidLoad()
        self.initAll()
    }
}

// Default Extension
extension Catalogue {
    
    func initAll() {
        self.navigationItem.title = "Catalogue"
        self.initPanel()
    }
}

// Menu Extension
extension Catalogue {
    
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


extension Catalogue: UITableViewDelegate {}

extension Catalogue: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! CatalogueTableViewCell
        
        cell.label.text = self.products[indexPath.row].label
        cell.desc.text = self.products[indexPath.row].description
        cell.price.text = String(self.products[indexPath.row].price) + " €"
        
        return cell
    }
    
    // On Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let id = self.products[indexPath.row].id else {
            return
        }
        
        let lo = Loading()
        
        self.redirectTo(from: self, to: lo)
        
        ProductService.default.find(id: String(id)) { (product) in
            
            let to = CatalogueProductDetail()
            
            to.product = product
            
            self.redirectTo(from: lo, to: to)
        }
    }
}
