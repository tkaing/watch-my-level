//
//  MenuManager.swift
//  watch-my-level
//
//  Created by DéjàLu on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class MenuManager {
    
    public static let `default` = MenuManager()
    
    public func BT(view: UIViewController) -> UIButton {
        
        let PI = view.navigationItem
        
        // Construct BG / IG
        let FM = CGRect(x: 0, y: 5, width: 25, height: 25)
        let BG = UIImageView(frame: FM)
        BG.image = #imageLiteral(resourceName: "menu")
        
        // Construct BT
        let BT = UIButton(frame: FM)
        BT.addSubview(BG)
        
        // BT -> PI
        PI.leftBarButtonItem = UIBarButtonItem(customView: BT)
        
        return BT
    }
    
    public func redirectTo(from: UIViewController, to: UIViewController) {
        
        from.navigationController?.pushViewController(to, animated: true)
    }
}
