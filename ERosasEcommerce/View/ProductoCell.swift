//
//  ProductoCell.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 16/05/23.
//

import UIKit
import SwipeCellKit

class ProductoCell: SwipeTableViewCell {
    
    @IBOutlet weak var Imagen: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    @IBOutlet weak var lblPrecio: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
