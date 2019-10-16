//
//  MenuManager.swift
//  watch-my-level
//
//  Created by DéjàLu on 16/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit
import SideMenu

class ColorManager {
    
    public static let `default` = ColorManager()
    
    public func primary(_ opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: 0x0275d8, alpha: opacity)
    }
    
    public func success(_ opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: 0x5cb85c, alpha: opacity)
    }
    
    public func info(_ opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: 0x5bc0de, alpha: opacity)
    }
    
    public func warning(_ opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: 0xf0ad4e, alpha: opacity)
    }
    
    public func danger(_ opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: 0xD9534F, alpha: opacity)
    }
    
    public func dark(_ opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: 0x292b2c, alpha: opacity)
    }
    
    public func light(_ opacity: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: 0xf7f7f7, alpha: opacity)
    }
}

extension UIColor {
    
    convenience init(rgb: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
