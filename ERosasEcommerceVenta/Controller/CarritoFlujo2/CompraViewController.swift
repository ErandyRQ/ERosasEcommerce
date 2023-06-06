//
//  CompraViewController.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 02/06/23.
//

import UIKit
import iOSDropDown
import SQLite3

class CompraViewController: UIViewController {
    
    
    @IBOutlet weak var lblArticulos: UILabel!
    
    @IBOutlet weak var lblPrecioTotal: UILabel!
    
    @IBOutlet weak var ddlMetodoPago: DropDown!
    
    @IBOutlet weak var btnComprar: UIButton!
    
    var IdMetodo: Int = 0
    var totalVenta : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblPrecioTotal.text = String("$ \(totalVenta)")

        ddlMetodoPago.didSelect { selectedText, index, id in self.IdMetodo = id}
        
        ddlMetodoPago.optionArray = []
        ddlMetodoPago.optionIds = []
        
        let resultMetodo = CompraViewModel.GetAllMetodo()
        if resultMetodo.Correct!{
            for objmetodo in resultMetodo.Objects!{
                let metodo = objmetodo as! MetodoPago
                ddlMetodoPago.optionArray.append(metodo.nombre!)
                ddlMetodoPago.optionIds?.append(metodo.idMetodo!)
            }
        }
    }
    

    @IBAction func ConfirmarCompra(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "Se realizo la compra", preferredStyle: .alert)
        let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        let img = UIImageView(frame: CGRect(x: 40, y: 70, width: 200, height: 190))
        
        img.image = UIImage (named: "Confirmacion")
        let action = UIAlertAction(title: "Aceptar", style: .default)
        alert.view.addSubview(img)
        alert.addAction(action)
        present(alert, animated: true)
        
        
        
    }
    

}
