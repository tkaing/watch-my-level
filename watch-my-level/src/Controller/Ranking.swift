//
//  Ranking.swift
//  watch-my-level
//
//  Created by DéjàLu on 18/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class Ranking: UIViewController {

    @IBOutlet var table: UITableView!
    
    public var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initAll()
    }
    
}
// Default Extension
extension Ranking {
    
    func initAll() {
        self.navigationItem.title = "Classement"
        self.initPanel()
        self.initTable()
    }
}

// Menu Extension
extension Ranking {
    
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
    
// Table Extension
extension Ranking: UITableViewDelegate, UITableViewDataSource {
    
    func initTable() {
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "RankingCell")
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    // Count Cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    // Cell Content
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell? = self.table.dequeueReusableCell(withIdentifier: "RankingCell")
        
        let title: String = self.users[indexPath.row].username
        
        cell?.textLabel?.text = String(indexPath.row + 1) + ". " + title
        
        return cell!
    }
    
    // On Select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
