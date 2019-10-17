//
//  CardCell.swift
//  watch-my-level
//
//  Created by DéjàLu on 17/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet var IG_BACK: UIImageView!
    @IBOutlet var IG_FRONT: UIImageView!
    
    var shown: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func showCard(_ show: Bool, animted: Bool) {
        
        self.IG_BACK.isHidden = false
        self.IG_FRONT.isHidden = false
        
        self.shown = show
        
        if animted {
            if show {
                UIView.transition(
                    from: self.IG_BACK,
                    to: self.IG_FRONT,
                    duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { (finished: Bool) -> () in
                })
            } else {
                UIView.transition(
                    from: self.IG_FRONT,
                    to: self.IG_BACK,
                    duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion:  { (finished: Bool) -> () in
                })
            }
        } else {
            if show {
                bringSubviewToFront(self.IG_FRONT)
                self.IG_BACK.isHidden = true
            } else {
                bringSubviewToFront(self.IG_BACK)
                self.IG_FRONT.isHidden = true
            }
        }
    }
}
