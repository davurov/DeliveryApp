//
//  ProductCell.swift
//  DeliveryApp
//
//  Created by Abduraxmon on 03/04/23.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var buyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buyBtn.layer.borderWidth = 1
        buyBtn.layer.borderColor = UIColor.red.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
