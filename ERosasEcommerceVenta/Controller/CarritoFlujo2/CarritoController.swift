//
//  CarritoController.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 26/05/23.
//

import UIKit
import SwipeCellKit

class CarritoController: UITableViewController {
    
    let carritoViewModel = CarritoViewModel()
    var producto : [Producto] = []
    var ventasProducto : [VentasProducto] = []
    
    override func viewWillAppear(_ animated: Bool) {
            
            tableView.reloadData()
            UpdateUI()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateUI()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ventasProducto.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoViewCell
        cell.delegate = self
        print(indexPath.row)
        print(ventasProducto[indexPath.row].producto!.Nombre!)
       // cell.lblNombre.text = "Test"//ventasProducto[indexPath.row].producto!.Nombre!
        cell.lblPrecio.text = ventasProducto[indexPath.row].producto?.PrecioUnitario
        cell.lblCantidad.text = ventasProducto[indexPath.row].cantidad as! String
        
        
        if ventasProducto[indexPath.row].producto?.Imagen == "" || ventasProducto[indexPath.row].producto?.Imagen == nil {
            cell.imagenP.image = UIImage(named: "DefaultProducto")
        }else{
            let string =  ventasProducto[indexPath.row].producto?.Imagen
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.imagenP.image = UIImage(data: newImageData)
            }
        }
        
        return cell
    
    }
    
    
}
extension CarritoController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                
                
                // let result =  UsuarioViewModel.Delete(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                
                //                if result.Correct! {
                //                    print("usuario Elimnado")
                //                    self.UdpateUI()
                //                }else{
                //                    print("Ocurrio un error")
                //                }
                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                //                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                //                self.performSegue(withIdentifier: "UsuarioControler", sender: self)
                //
            }
            return [updateAction]
        }
        return nil
        
        
    }
    func UpdateUI(){
        var result = carritoViewModel.GetAll()
            ventasProducto.removeAll()
            if result.Correct!{
                for objUsuario in result.Objects!{
                    let product = objUsuario as! VentasProducto//Unboxing
                    ventasProducto.append(product)
                }
                tableView.reloadData()
                
            }
        }
    
}
