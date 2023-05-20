//
//  ProductoViewModel.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 16/05/23.
//

import Foundation
import SQLite3

class ProductoViewModel{
    
    //Metodos
    
    static func Add(producto: Producto)-> Result
    {
        var result = Result()
        var context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "INSERT INTO Producto(Nombre,PrecioUnitario,Stock,Descripcion,Imagen,IdProveedor,IdDepartamento) VALUES(?,?,?,?,?,?,?)"
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                sqlite3_bind_text(statement,1, (producto.Nombre as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,2, (producto.PrecioUnitario as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,3, (producto.Stock as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,4, (producto.Descripcion as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,5, (producto.Imagen! as NSString).utf8String , -1 , nil)
                
                sqlite3_bind_int64(statement, 6, sqlite3_int64((producto.Proveedor?.IdProveedor) as! NSNumber))
                sqlite3_bind_int64(statement, 7, sqlite3_int64((producto.Departamento?.IdDepartamento) as! NSNumber))
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                    result.Correct = true
                    print("Producto insertado")
                }else{
                    print("Error al insert")
                }
                
            }else{
                result.Correct = false
                print("Ocurrio un error")
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription
            result.Ex = ex
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
    }
    
    
    
    static func Update(producto: Producto) -> Result
    {
        var result = Result()
        var context = DBManager()
        var statement : OpaquePointer? = nil
        var query = "UPDATE Producto SET Nombre = ?, PrecioUnitario = ?, Stock = ?, Descripcion = ?, Imagen = ?, IdProveedor = ?, IdDepartamento = ? WHERE IdProducto = \(producto.IdProducto!)"
        
        do{
            if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                
                
                sqlite3_bind_text(statement,1, (producto.Nombre as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,2, (producto.PrecioUnitario as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,3, (producto.Stock as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,4, (producto.Descripcion as! NSString).utf8String , -1 , nil)
                sqlite3_bind_text(statement,5, (producto.Imagen as! NSString).utf8String , -1 , nil)
                
                sqlite3_bind_int64(statement, 6, sqlite3_int64((producto.Proveedor?.IdProveedor)as! NSNumber))
                sqlite3_bind_int64(statement, 7, sqlite3_int64((producto.Departamento?.IdDepartamento)as! NSNumber))
                
                
                if(sqlite3_step(statement) == SQLITE_DONE){
                    result.Correct = true
                    print("Producto actualizado")
                }else{
                    print("Error al insert")
                }
                
            }else{
                result.Correct = false
                print("Ocurrio un error")
            }
        }catch let ex{
            sqlite3_finalize(statement)
            sqlite3_close(context.db)
            return result
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        return result
            }
    
    static func Delete(IdProducto: Int)->Result{
        var context = DBManager()
        var result = Result()
        var statement : OpaquePointer? = nil
        var query = "DELETE FROM Producto WHERE IdProducto = \(IdProducto)"
        do {
            if try (sqlite3_prepare_v2(context.db, query, -1, &statement, nil)) == SQLITE_OK {
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                    print("Producto eliminado")
                }else{
                    result.Correct = false
                    result.ErrorMessage = "No se elimino"
                }
            }else{
                result.Correct = false
                result.ErrorMessage = "ocurrio un error"
            }
        }catch let ex{
            result.Correct = false
            result.ErrorMessage = ex.localizedDescription //Ex.Message
            result.Ex = ex
            
        }
        sqlite3_finalize(statement)
        sqlite3_close(context.db)
        
           return result
        
            }
    
    static func GetAll() -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdProducto, Producto.Nombre, PrecioUnitario, Stock, Descripcion, Imagen, Proveedor.IdProveedor, Proveedor.Nombre, Departamento.IdDepartamento, Departamento.Nombre FROM Producto JOIN Proveedor ON Producto.IdProveedor = Proveedor.IdProveedor JOIN Departamento ON Producto.IdDepartamento = Departamento.IdDepartamento"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
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
    static  func GetById(IdProducto: Int)->Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdProducto, Producto.Nombre, PrecioUnitario, Stock, Descripcion, Imagen, Proveedor.IdProveedor, Proveedor.Nombre, Departamento.IdDepartamento, Departamento.Nombre FROM Producto JOIN Proveedor ON Producto.IdProveedor = Proveedor.IdProveedor JOIN Departamento ON Producto.IdDepartamento = Departamento.IdDepartamento WHERE IdProducto = \(IdProducto)"
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
    
    static func GetAllDepartamento() -> Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdDepartamento, Nombre FROM Departamento"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var departamento = Departamento()
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
                    departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    //                    producto.Departamento = Departamento()
                    //                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
                    //                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 9)))
                    //
                    
                    result.Objects?.append(departamento)
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
    
    static func GetAllArea() -> Result{
           var context = DBManager()
           var result = Result()
           let query = "SELECT IdArea, Nombre FROM Area"
           var statement : OpaquePointer?
           do{
               if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                   result.Objects = []
                   while try sqlite3_step(statement) == SQLITE_ROW {
                       var area = Area()
                       area.IdArea = Int(sqlite3_column_int(statement, 0))
                       area.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                      
   //                    producto.Departamento = Departamento()
   //                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
   //                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 9)))
   //
                       
                       result.Objects?.append(area)
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
    
    static func GetAllProveedor() -> Result{
               var context = DBManager()
               var result = Result()
               let query = "SELECT IdProveedor, Nombre FROM Proveedor"
               var statement : OpaquePointer?
               do{
                   if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                       result.Objects = []
                       while try sqlite3_step(statement) == SQLITE_ROW {
                           var proveedor = Proveedor()
                           proveedor.IdProveedor = Int(sqlite3_column_int(statement, 0))
                           proveedor.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                      
      
                           
                           result.Objects?.append(proveedor)
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
    
    static  func GetByIdArea(IdArea: Int)->Result{
        var context = DBManager()
        var result = Result()
        let query = "SELECT IdArea, Nombre WHERE IdArea = \(IdArea)"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                if try sqlite3_step(statement) == SQLITE_ROW {
                    var area = Area()
                    area.IdArea = Int(sqlite3_column_int(statement, 0))
                    area.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    
                    result.Object = area
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
    
//    static func GetAllDepartamento() -> Result{
//        var context = DBManager()
//        var result = Result()
//        let query = "SELECT IdDepartamento, Nombre FROM Departamento"
//        var statement : OpaquePointer?
//        do{
//            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
//                result.Objects = []
//                while try sqlite3_step(statement) == SQLITE_ROW {
//                    var departamento = Departamento()
//                    departamento.IdDepartamento = Int(sqlite3_column_int(statement, 0))
//                    departamento.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
//                    
//                    //                    producto.Departamento = Departamento()
//                    //                    producto.Departamento?.IdDepartamento = Int(sqlite3_column_int(statement, 8))
//                    //                    producto.Departamento?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 9)))
//                    //
//                    
//                    result.Objects?.append(departamento)
//                }
//                result.Correct = true
//            }else  {
//                result.Correct = false
//                result.ErrorMessage = "Ocurrio un error"
//            }
//        }
//        catch let ex{
//            result.Correct = false
//            result.ErrorMessage = ex.localizedDescription //Ex.Message
//            result.Ex = ex
//        }
//        sqlite3_finalize(statement)
//        sqlite3_close(context.db)
//        return result
//    }
    
}
