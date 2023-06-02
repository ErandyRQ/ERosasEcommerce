//
//  CarritoViewModel.swift
//  ERosasEcommerceVenta
//
//  Created by MacBookMBA9 on 26/05/23.
//

import Foundation
import UIKit
import CoreData



class CarritoViewModel{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
    func Add(_ IdProducto : Int) -> Result{
        
        var result = Result()
               
               let context = appDelegate.persistentContainer.viewContext
               
               let entity = NSEntityDescription.entity(forEntityName: "VentaProducto", in: context)!
               
               let producto = NSManagedObject(entity: entity, insertInto: context)
               
               producto.setValue(IdProducto, forKey: "idProducto")
               producto.setValue(1, forKey: "cantidad")
               
               do{
                   try context.save()
                   result.Correct = true
               }
               catch let error {
                   result.Correct = false
                   result.ErrorMessage = error.localizedDescription
                   result.Ex = error
               }
               
               return result
    }
    func Update(IdProducto : Int, Cantidad : Int) -> Result{
              
              var result = Result()
           
           //var ventaproducto = CarritoViewModel()
           
              let context = appDelegate.persistentContainer.viewContext
              
           let response : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "VentaProducto")
              
              response.predicate = NSPredicate(format: "idProducto = \(IdProducto)")
           do{
               let test = try context.fetch(response)
               
               let objectUpdate = test[0] as! NSManagedObject
               objectUpdate.setValue(Cantidad, forKey: "cantidad")
               do{
                   try context.save()
                   result.Correct = true
                   //result.Correct = false
               }catch let error{
                   result.Correct = false
                   result.ErrorMessage = error.localizedDescription
                   result.Ex = error               }
           }catch let error{
               result.Correct = false
               result.ErrorMessage = error.localizedDescription
               result.Ex = error
           }
           return result
          }
    
    func Delete(IdProducto : Int) -> Result{


             var result = Result()
               
               let context = appDelegate.persistentContainer.viewContext
               
               let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
               
               response.predicate = NSPredicate(format: "idProducto = \( IdProducto)")
               
               do{
                   let test = try context.fetch(response)
                   
                   let objectToDelete = test[0] as! NSManagedObject
                   context.delete(objectToDelete)
                   do{
                       try context.save()
                       result.Correct = true
                   }catch let error{
                       result.Correct = false
                       result.ErrorMessage = error.localizedDescription
                       result.Ex = error               }
               }catch let error{
                   result.Correct = false
                   result.ErrorMessage = error.localizedDescription
                   result.Ex = error
               }
               return result
           }
    
    func GetById(IdProducto : Int) -> Result{
               
               var result = Result()
               
               let context = appDelegate.persistentContainer.viewContext
               
               let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
              
               response.predicate = NSPredicate(format: "idProducto = \( IdProducto)")
               
               do{
                   result.Object = []
                   let resultFetch = try context.fetch(response)
                   for obj in resultFetch as! [NSManagedObject]{
                       //Instancia de venta producto //Crear Modelo
                       let modelo = VentasProducto()
                       
                       modelo.producto = Producto()
                       
                       modelo.producto?.IdProducto =  obj.value(forKey:"idProducto") as! Int
                       modelo.cantidad = obj.value(forKey: "cantidad") as! Int
                    
                       let resultGetGetById = ProductoViewModel.GetById(IdProducto: modelo.producto?.IdProducto as! Int)
                       if resultGetGetById.Correct!{
                           let producto = resultGetGetById.Object! as! Producto
                           
                           modelo.producto?.Nombre = producto.Nombre
                           modelo.producto?.Imagen = producto.Imagen
                       }
                     
                       result.Object = modelo
                      
                   }
                 
                   result.Correct = true
               }
               catch let error {
                   result.Correct = false
                   result.ErrorMessage = error.localizedDescription
                   result.Ex = error
               }
               
               return result
           }
    
    
    func GetAll() -> Result{
        
        var result = Result()
                
    
                let context = appDelegate.persistentContainer.viewContext
                
                let response = NSFetchRequest<NSFetchRequestResult> (entityName: "VentaProducto")
                
                do{
                    result.Objects = []
                    let resultFetch = try context.fetch(response)
                    for obj in resultFetch as! [NSManagedObject]{
                        
                        let ventaProducto = VentasProducto()
                        ventaProducto.producto = Producto()
                            
                        ventaProducto.producto?.IdProducto = obj.value(forKey: "idProducto") as! Int
                        ventaProducto.cantidad = obj.value(forKey: "cantidad") as! Int
                        
                        let resultGetById = ProductoViewModel.GetById(IdProducto: ventaProducto.producto?.IdProducto as! Int)
                        
                        if resultGetById.Correct!{
                            let producto = resultGetById.Object! as! Producto
                            
                            ventaProducto.producto?.Nombre = producto.Nombre
                            ventaProducto.producto?.Imagen = producto.Imagen
                            ventaProducto.producto?.PrecioUnitario = producto.PrecioUnitario
                        }
                        result.Objects?.append(ventaProducto)
                    }
                    result.Correct = true
                }
                catch let error {
                    result.Correct = false
                    result.ErrorMessage = error.localizedDescription
                    result.Ex = error
                }
                
                return result
            }
    }
    

