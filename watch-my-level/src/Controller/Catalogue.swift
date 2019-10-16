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
    
    public var items: [String] = []
    
    public var cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
}

// Menu Catalogue
extension Catalogue {
    
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

// Front Catalogue
extension Catalogue {
    
    func initView() {
        
        // ST Menu
        self.initPanel()
        self.navigationItem.title = "Catalogue"
        
        // ST Table
        self.initTable()
        
        // ST Front
        
        // --------
    }
    
    func setImage(BT: UIButton) {
        
        BT.imageView?.contentMode = .scaleAspectFit
    }
}

// Table Catalogue
extension Catalogue: UITableViewDelegate, UITableViewDataSource {
    
    func initTable() {
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    // Count Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // Cell Content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = self.table.dequeueReusableCell(withIdentifier: self.cellID)
        let name: String = self.items[indexPath.row]
        print(name)
        cell?.textLabel?.text = name
        return cell!
    }
    
    /*// Edit = Cell Action Leading
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let colorUtils = ColorManager()
        
        let editAction = UIContextualAction(style: .normal, title: "", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            //let course: String = self.items[indexPath.row]
            
            let to = Home()
            
            //to.course = course
            
            self.redirectTo(from: self, to: to)
            
            success(true)
        })
        
        var IG = #imageLiteral(resourceName: "edit")
        IG = self.resizeImage(image: IG, targetSize: CGSize(width: 30.0, height: 30.0))
        
        editAction.image = IG
        editAction.backgroundColor = colorUtils.warning()
        
        return UISwipeActionsConfiguration(actions: [editAction])
        
    }
    
    // Delete = Cell Action Trailing
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let colorUtils = ColorManager()
        
        let deleteAction = UIContextualAction(style: .normal, title: "", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            /*let course: Course = self.courses[indexPath.row]
             
             self.courses.remove(at: indexPath.row)
             
             self.tableView.deleteRows(at: [indexPath], with: .automatic)
             
             guard let id = course.id else { return }
             
             CourseService.default.delete(id: id, complete: { (status) in
             print(status)
             })*/
            
            success(true)
        })
        
        var IG = #imageLiteral(resourceName: "garbage")
        IG = self.resizeImage(image: IG, targetSize: CGSize(width: 30.0, height: 30.0))
        
        deleteAction.image = IG
        deleteAction.backgroundColor = colorUtils.danger()
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }*/
    
    // Show = Cell On Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let course: Course = self.courses[indexPath.row]
        
        let to = self
        
        self.redirectTo(from: self, to: to)
    }
}

// Image Extension
extension Catalogue {
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
