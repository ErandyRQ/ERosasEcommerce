//
//  ProductoCollectionController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 23/05/23.
//

import UIKit
import SQLite3

private let reuseIdentifier = "ProductoCollectionCell"

class ProductoCollectionController: UICollectionViewController {
    
    @IBOutlet var collectionProducto: UICollectionView!
    
    let carritoViewModel = CarritoViewModel()
    
    var producto : [Producto] = []
    
    var IdDepartamento : Int = 0
    var Id : Int = 0
    var palabra : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ProductoCollectionCell", bundle: .main), forCellWithReuseIdentifier: "ProductoCollectionCell")
        collectionProducto.delegate = self
        collectionProducto.dataSource = self
        //updateUI()
        
        print("el departamento es: \(IdDepartamento)")
        print("el area es: \(palabra)")
        
        if IdDepartamento == 0{
                  
                  var result = ProductoSearch.GetAllProducto(Palabra: palabra)
                  producto.removeAll()
                  if result.Correct!{
                      for objdepartamento in result.Objects!{
                          let resultado = objdepartamento as! Producto
                          //Unboxing
                          producto.append(resultado)
                      }
                      collectionView?.reloadData()
                  }
                  
        }else{
            
            
            var result = ProductoCollectionViewModel.GetbyIdProduct(IdDepartamento: IdDepartamento)
                  producto.removeAll()
                  if result.Correct!{
                      for objdepartamento in result.Objects!{
                          let resultado = objdepartamento as! Producto
                          //Unboxing
                          producto.append(resultado)
                      }
                      collectionView?.reloadData()
                  }
              }

        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return producto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductoCollectionCell
        
        cell.lblNombre.text = producto[indexPath.row].Nombre
        cell.lblPrecio.text = producto[indexPath.row].PrecioUnitario?.description
        cell.lblDescripcion.text = producto[indexPath.row].Descripcion
        
        if producto[indexPath.row].Imagen == "" || producto[indexPath.row].Imagen == nil {
            cell.imageView.image = UIImage(named: "DefaultProducto")
        }else{
            let string = producto[indexPath.row].Imagen
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                cell.imageView.image = UIImage(data: newImageData)
                
               
            }
            
        }
        
        cell.btnAgregar.tag = indexPath.row
        cell.btnAgregar.addTarget(self, action: #selector(AddCarrito), for: .touchUpInside)
    
        return cell
    }
    
    @objc func AddCarrito(sender : UIButton){
        
        let idProducto = producto[sender.tag].IdProducto! 
        
        print("El Idproducto es: \(idProducto)")
           
           let result = carritoViewModel.Add(idProducto)
           if result.Correct! {
               
               let alert = UIAlertController(title: "Mensaje", message: "Se agrego el producto", preferredStyle: .alert)
               let action = UIAlertAction(title: "Aceptar", style: .default)
               alert.addAction(action)
               self.present(alert, animated: true, completion: nil)
               
           }else{
               
            let alert = UIAlertController(title: "Mensaje", message: "No se agrego el producto", preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
                               
           }
        carritoViewModel.GetAll()
       }

    
}

