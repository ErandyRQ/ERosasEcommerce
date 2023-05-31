//
//  ProductoSearch.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 24/05/23.
//

import Foundation
import SQLite3

class ProductoSearch{
    
    var result = Result()
        var context = DBManager()

        
        static func GetAllProducto(Palabra : String) -> Result{
            var context = DBManager()
            var result = Result()
            let query = "SELECT IdProducto, Nombre, PrecioUnitario, Descripcion, Imagen FROM Producto WHERE Nombre LIKE'%\(Palabra)%'"
            var statement : OpaquePointer?
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                    result.Objects = []
                    while try sqlite3_step(statement) == SQLITE_ROW {
                        var producto = Producto()
                        producto.IdProducto = Int(sqlite3_column_int(statement, 0))
                        producto.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                        producto.PrecioUnitario = Int(sqlite3_column_int(statement, 2))
                        producto.Descripcion = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                        producto.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                        
                        result.Objects?.append(producto)
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
