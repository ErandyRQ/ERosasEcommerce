//
//  ProductoCarritoControllerTableViewCell.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 26/05/23.
//

import UIKit

class ProductoCarritoControllerTableViewCell: UITableViewCell {
    
    
    
    
    
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBOutlet weak var lblCantidad: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
