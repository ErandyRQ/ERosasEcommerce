//
//  CompraViewModel.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 02/06/23.
//

import Foundation
import SQLite3

class CompraViewModel {
    
    static func GetAllMetodo() -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdMetodo, Nombre FROM MetodoPago"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var metodo = MetodoPago()
                    metodo.idMetodo = Int(sqlite3_column_int(statement, 0))
                    metodo.nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    
                    
                    result.Objects?.append(metodo)
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

