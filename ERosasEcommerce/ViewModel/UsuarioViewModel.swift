//
//  UsuarioViewModel.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 04/05/23.
//

import Foundation
import SQLite3

class UsuarioViewModel{
    
    
    //Metodos
    
    static func Add(usuario: Usuario)-> Result
        {
            var result = Result()
            var context = DBManager()
            var statement : OpaquePointer? = nil
            var query = "INSERT INTO Usuario(Nombre,ApellidoPaterno,ApellidoMaterno,FechaNacimiento,Username,Password,IdRol) VALUES(?,?,?,?,?,?,?)"
            do{
                if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                    
                    sqlite3_bind_text(statement,1, (usuario.Nombre as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,2, (usuario.ApellidoPaterno as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,3, (usuario.ApellidoMaterno as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,4, (usuario.FechaNacimiento as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,5, (usuario.Username as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,6, (usuario.Password as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_int64(statement, 7, sqlite3_int64((usuario.Rol?.IdRol) as! NSNumber))
                    
                    if(sqlite3_step(statement) == SQLITE_DONE){
                        result.Correct = true
                        print("Usuario insertado")
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
    
    
    
    static func Update(usuario: Usuario) -> Result
        {
            var result = Result()
            var context = DBManager()
            var statement : OpaquePointer? = nil
            var query = "UPDATE Usuario SET Nombre = ?, ApellidoPaterno = ?, ApellidoMaterno = ?, FechaNacimiento = ?, Username = ?, Password = ?, IdRol = ? WHERE IdUsuario = \(usuario.IdUsuario!)"
            
            do{
                if(sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK){
                    
                    
                    sqlite3_bind_text(statement,1, (usuario.Nombre as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,2, (usuario.ApellidoPaterno as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,3, (usuario.ApellidoMaterno as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,4, (usuario.FechaNacimiento as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,5, (usuario.Username as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_text(statement,6, (usuario.Password as! NSString).utf8String , -1 , nil)
                    sqlite3_bind_int64(statement, 7, sqlite3_int64((usuario.Rol?.IdRol)as! NSNumber))
                    
                    
                    if(sqlite3_step(statement) == SQLITE_DONE){
                        result.Correct = true
                        print("Usuario actualizado")
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
    
    static func Delete(IdUsuario: Int)->Result{
                var context = DBManager()
                var result = Result()
                var statement : OpaquePointer? = nil
                var query = "DELETE FROM Usuario WHERE IdUsuario = \(IdUsuario)"
                do {
                    if try (sqlite3_prepare_v2(context.db, query, -1, &statement, nil)) == SQLITE_OK {
                        if sqlite3_step(statement) == SQLITE_DONE{
                            result.Correct = true
                            print("Usuario eliminado")
                        }else{
                            result.Correct = false
                            result.ErrorMessage = "no se elimino"
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
        let query = "SELECT IdUsuario, Usuario.Nombre, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Username, Password, Rol.IdRol, Rol.Nombre FROM Usuario JOIN Rol ON Usuario.IdRol = Rol.IdRol"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while try sqlite3_step(statement) == SQLITE_ROW {
                    var usuario = Usuario()
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    usuario.FechaNacimiento = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    usuario.Username = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    usuario.Password = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                    
                    usuario.Rol = Rol()
                    usuario.Rol?.IdRol = Int(sqlite3_column_int(statement, 7))
                    usuario.Rol?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 8)))
                    
                    
                    result.Objects?.append(usuario)
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
   static  func GetById(IdUsuario: Int)->Result{
       var context = DBManager()
       var result = Result()
        let query = "SELECT IdUsuario,Usuario.Nombre,ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Username, Password, Rol.IdRol, Rol.Nombre FROM Usuario JOIN ROL ON Usuario.IdRol = Rol.IdRol WHERE IdUsuario = \(IdUsuario)"
        var statement : OpaquePointer?
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                if try sqlite3_step(statement) == SQLITE_ROW {
                    var usuario = Usuario()
                    usuario.IdUsuario = Int(sqlite3_column_int(statement, 0))
                    usuario.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    usuario.FechaNacimiento = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    usuario.Username = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    usuario.Password = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                    
                    usuario.Rol = Rol()
                    usuario.Rol?.IdRol = Int(sqlite3_column_int(statement, 7))
                    usuario.Rol?.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 8)))
                    //result.Objects?.append(usuario)
                    
                    result.Object = usuario
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
