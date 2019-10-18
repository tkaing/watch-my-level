//
//  CatalogueTableViewCell.swift
//  watch-my-level
//
//  Created by Viviana Montiel on 17/10/2019.
//  Copyright © 2019 wml. All rights reserved.
//

import UIKit

class CatalogueTableViewCell: UITableViewCell {

    @IBOutlet var label: UILabel!
    @IBOutlet var desc: UITextView!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.desc.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
