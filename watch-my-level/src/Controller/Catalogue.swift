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
    
    public var items: [String] = ["a","b","c"]
    
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
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellID, for: indexPath) as! CatalogueTableViewCell
        
        /*let watch = watchs[indexPath.row]
        let imageURL = URL(string: watch.image)
        let imageData = try! Data(contentsOf: imageURL!)
        cell.watchImageView.image = UIImage(data: imageData)
        
        cell.watchPriceLabel.text = "\(watch.prix)€"
    
        cell.watchNameLabel.text = watch.nom*/
        cell.label.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let watch = WatchDetailViewController.newInstance(watch: watchs[indexPath.row], user: self.user)
//        self.navigationController?.pushViewController(watch, animated: true)
    }

}
