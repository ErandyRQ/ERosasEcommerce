//
//  AreaViewModel.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 23/05/23.
//

import Foundation
import SQLite3

class AreaViewModel{
    static  func GetByIdArea(IdArea: Int)->Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdArea,Nombre WHERE IdArea = \(IdArea)"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                if try sqlite3_step(statement) == SQLITE_ROW {
                    var producto = Producto()
                    producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                    producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    producto.PrecioUnitario = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    producto.Stock = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    
                    
                    producto.Proveedor = Proveedor()
                    producto.Proveedor?.IdProveedor = Int(sqlite3_column_int(statement, 6))
                    producto.Proveedor?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 7)))
                    
                    producto.Departamento = Departamento()
                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 9)))
                    
                    result.Object = producto
                }
                result.Correct = true
            }else  {
                result.Correct = false
                result.ErrorMessage = "Ocurrio un error"
            }
        }
        catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
}
