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
    
        return cell
    }

    
}
