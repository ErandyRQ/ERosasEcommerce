//
//  ProductoCollectionCellCollectionViewController.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 25/05/23.
//

import UIKit
import SQLite3

private let reuseIdentifier = "ProductoCollectionCell"

class ProductoCollectionCellCollectionViewController: UICollectionViewController {
    
    
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
      //  self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
