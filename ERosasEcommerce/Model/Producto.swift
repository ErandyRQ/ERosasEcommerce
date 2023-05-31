//
//  Producto.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 16/05/23.
//

import Foundation
import SQLite3

class Producto{
    
    
    //Propiedades
    var IdProducto : Int? = nil
    var Nombre : String? = nil
    var PrecioUnitario : Int? = nil //checar lo del string 
    var Stock : String? = nil
    var Descripcion : String? = nil
    var Imagen : String? = nil
   
    var Proveedor : Proveedor? = nil  
    var Departamento : Departamento? = nil
    
    
   
}
