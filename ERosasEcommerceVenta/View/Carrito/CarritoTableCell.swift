//
//  CarritoTableCell.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 30/05/23.
//

import UIKit
import SwipeCellKit

class CarritoTableCell: SwipeTableViewCell {
    
    
    @IBOutlet weak var Imagen: UIImageView!
    
    @IBOutlet weak var Nombrelbl: UILabel!
    
    @IBOutlet weak var cantidadlbl: UILabel!
    
    @IBOutlet weak var incremento: UIStepper!
    
    
    @IBOutlet weak var preciolbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
