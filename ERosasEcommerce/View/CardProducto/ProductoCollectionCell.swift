//
//  ProductoCollectionCell.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 23/05/23.
//

import UIKit

class ProductoCollectionCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    @IBOutlet weak var lblPrecio: UILabel!
    
    
    @IBOutlet weak var btnAgregar: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
