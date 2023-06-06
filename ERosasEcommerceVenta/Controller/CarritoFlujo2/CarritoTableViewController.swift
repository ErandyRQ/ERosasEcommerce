//
//  CarritoTableViewController.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 30/05/23.
//

import UIKit
import SwipeCellKit

class CarritoTableViewController: UIViewController {
    
    
    @IBOutlet weak var tableViewCarrito: UITableView!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    var total : Double = 0
    var subtotal : Double = 0
    let carritoViewModel = CarritoViewModel() //Métodos
    var ventasProducto : [VentasProducto] = []
    
    override func viewWillAppear(_ animated: Bool) {
            
            tableViewCarrito.reloadData()
            UpdateUI()
        }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableViewCarrito.register(UINib(nibName: "CarritoTableCell", bundle: .main), forCellReuseIdentifier:"CarritoCell")
        
        tableViewCarrito.delegate = self
        tableViewCarrito.dataSource = self
        UpdateUI()
    }

    
}
extension CarritoTableViewController : UITableViewDataSource, UITableViewDelegate {
func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return ventasProducto.count
}


func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CarritoCell", for: indexPath) as! CarritoTableCell

    cell.delegate = self
    
    print(indexPath.row)
    print(ventasProducto[indexPath.row].producto!.Nombre!)
    cell.Nombrelbl.text = ventasProducto[indexPath.row].producto?.Nombre
    cell.preciolbl.text = ventasProducto[indexPath.row].producto?.PrecioUnitario?.description
    cell.cantidadlbl.text = ventasProducto[indexPath.row].cantidad?.description
    
    
    if ventasProducto[indexPath.row].producto?.Imagen == "" || ventasProducto[indexPath.row].producto?.Imagen == nil {
        cell.Imagen.image = UIImage(named: "DefaultProducto")
    }else{
        let string =  ventasProducto[indexPath.row].producto?.Imagen
        let newImageData = Data(base64Encoded: string!)
        if let newImageData = newImageData {
            cell.Imagen.image = UIImage(data: newImageData)
        }
    }
    
    subtotal = Double(ventasProducto[indexPath.row].cantidad!*(ventasProducto[indexPath.row].producto?.PrecioUnitario ?? 0))
    cell.preciolbl.text = String (subtotal)
    
    cell.incremento.value = Double(ventasProducto[indexPath.row].cantidad!)
    cell.incremento.tag = indexPath.row
    cell.incremento.addTarget(self, action: #selector(incrementoAction), for: .touchUpInside)
    
    self.total = total + subtotal
    lblTotal.text = String("$ \(total)")

    return cell
}


    
    
}
extension CarritoTableViewController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                
                
                let result =  carritoViewModel.Delete(IdProducto: self.ventasProducto[indexPath.row].producto?.IdProducto as! Int)
                
                if result.Correct! {
                    print("usuario Elimnado")
                    self.UpdateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            return [deleteAction]
        }
        return nil
    }
    
    func UpdateUI(){
        var result = carritoViewModel.GetAll()
            ventasProducto.removeAll()
            if result.Correct!{
                for objUsuario in result.Objects!{
                    total = 0
                    let product = objUsuario as! VentasProducto//Unboxing
                    ventasProducto.append(product)
                }
                
                tableViewCarrito.reloadData()
            }
        }
    
    @objc func incrementoAction(sender: UIStepper) {
           let indexPath = IndexPath(row: sender.tag, section: 0)
           print("sender ---> \(sender.value)")
           if sender.value >= 1{
               if carritoViewModel.Update(IdProducto: (ventasProducto[indexPath.row].producto?.IdProducto)!,Cantidad: Int(sender.value)).Correct!{
                   total = 0.0
                   UpdateUI()
                   print("Actualizo")
               }else{
                   print("no se puede actualizar")
               }
           }else{
               if (sender.value == 0){
                   let result = CarritoViewModel().Delete(IdProducto: self.ventasProducto[indexPath.row].producto!.IdProducto!)
                   
                   if result.Correct!{
                       print("Producto eliminado")
                       self.UpdateUI()
                   }else{
                       print("Ocurrio un error")
                   }
               }
           }
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "seguesCompra" {
            let compra = segue.destination as! CompraViewController
            compra.totalVenta = total
        }
    }
}

