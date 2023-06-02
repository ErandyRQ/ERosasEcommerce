//
//  GetAllProductoController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 16/05/23.
//

import UIKit
import SwipeCellKit
import SwipeCellKit

class GetAllProductoController: UITableViewController {
    
    
    let dbmanager = DBManager()
    var productos : [Producto] = []
    var IdProducto : Int = 0
    var IdArea : Int = 0
        
    override func viewWillAppear(_ animated: Bool) {
            updateUI()
            tableView.reloadData()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ProductoCell", bundle: .main), forCellReuseIdentifier:"ProductoCell")
        updateUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductoCell", for: indexPath) as! ProductoCell
        
        cell.delegate = self
        
        cell.lblNombre.text = productos[indexPath.row].Nombre
        cell.lblDescripcion.text = productos[indexPath.row].Descripcion
        cell.lblPrecio.text = productos[indexPath.row].PrecioUnitario?.description
        
        
        if productos[indexPath.row].Imagen == "" || productos[indexPath.row].Imagen == nil {
            cell.Imagen.image = UIImage(named: "DefaultProducto")
               }else{
                   
                   let string =  productos[indexPath.row].Imagen
                  
                   
                   let newImageData = Data(base64Encoded: string!)
                   if let newImageData = newImageData {
                       cell.Imagen.image = UIImage(data: newImageData)
                   }
                 //else
               }

        return cell
    }
   
}
extension GetAllProductoController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                let result = ProductoViewModel.Delete(IdProducto: self.productos[indexPath.row].IdProducto!)
                
                if result.Correct!{
                    print("Producto eliminado")
                    //self.updateUI()
                }else{
                    print("Ocurrio un error")
                }
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                self.IdProducto = self.productos[indexPath.row].IdProducto!
                self.performSegue(withIdentifier: "ProductoViewController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
    
    func updateUI(){
        var result = ProductoViewModel.GetAll()
        productos.removeAll()
        if result.Correct!{
            for objProducto in result.Objects!{
                let producto = objProducto as! Producto //Unboxing
                productos.append(producto)
            }
            tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //sgue prepare
        if segue.identifier == "ProductoViewController"{
            let formControl = segue.destination as! ProductoViewController
            formControl.IdProducto = self.IdProducto 
            
            
        }
        
        
    }
    
    
}
