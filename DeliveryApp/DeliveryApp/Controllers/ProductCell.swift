//
//  ProductCell.swift
//  DeliveryApp
//
//  Created by Abduraxmon on 03/04/23.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var pizzaPhoto: UIImageView!
    @IBOutlet weak var pizzaName: UILabel!
    @IBOutlet weak var pizzaDesc: UILabel!
    var pizza: ProductModelElement?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buyBtn.layer.borderWidth = 1
        buyBtn.layer.borderColor = UIColor.red.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:ProductModelElement) {
        self.pizza = v
        
        guard pizza != nil else {
            return
        }
        
        self.pizzaName.text = pizza?.name
        self.buyBtn.setTitle("от $ \(pizza!.price!)", for: .normal)
        
        guard self.pizza!.img != "" else {
            return
        }
        
        if let cachedData = CacheManager.getImageCache((self.pizza?.img)!) {
            self.pizzaPhoto.image = UIImage(data: cachedData)
            return
        }
        
        let url = URL(string: self.pizza!.img ?? "")
        // Get the shared url session object
        let session = URLSession.shared
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                // save data  in the cache
                CacheManager.setImageCache(url!.absoluteString, data)
                // check the downloaded data match the image
                if url!.absoluteString != self.pizza?.img {
                    return
                }
                //Create image object
                let image = UIImage(data: data!)
                //set the imageView
                DispatchQueue.main.async {
                    self.pizzaPhoto.image = image
                }
            }
            
        }
        // start dataTask
        dataTask.resume()
        
    }
    
}
