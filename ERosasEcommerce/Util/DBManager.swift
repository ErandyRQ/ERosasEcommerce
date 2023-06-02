//
//  DBManager.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 28/04/23.
//

import Foundation
import SQLite3
class DBManager{

    
    var db: OpaquePointer?//Referencia al espacio en memoria
    let path: String = "Document.ERosasEcommerce.sqlite"
    
    init(){
        self.db = Get()
    }
    
    func Get() -> OpaquePointer?{
        let filePathCompartido = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ERosasEcommerce")!.appendingPathComponent(path)
      // print (filePathCompartido)
        
        let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(path)
        if(sqlite3_open(filePathCompartido.path, &db) == SQLITE_OK){
            print("Conexión exitosa")
            
            return db
        }else{
            print("Fallo la conexión")
            return nil
        }
    }
    
    
        
    
}
