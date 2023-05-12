//
//  RolGetAllController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 11/05/23.
//

import UIKit
import SwipeCellKit

class RolGetAllController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var rol : [Rol] = []
        
    var IdRol : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
          //updateUI()
          tableView.reloadData()
      }
      
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "RolCell", bundle: .main), forCellReuseIdentifier:"RolCell")
           
           tableView.delegate = self
           tableView.dataSource = self
         
           
           updateUI()   
    }

}

extension RolGetAllController :UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        self.rol.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RolCell", for: indexPath) as! RolCell
       
        cell.delegate = self
        
       // cell.lblidrol.text = rol[indexPath.row].idRol?.description
        cell.lblNombre.text = rol[indexPath.row].Nombre
        
        
        return cell
    }
}

extension RolGetAllController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
                   let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                       
                       
                       let result =  RolViewModel.Delete(idRol: self.rol[indexPath.row].IdRol!)
                       
                       if result.Correct! {
                           print("Rol Elimnado")
                           self.updateUI()
                       }else{
                           print("Ocurrio un error")
                       }
                       
                   }
                   return [deleteAction]
               }
               if orientation == .left {
                   let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                       
                       self.IdRol = self.rol[indexPath.row].IdRol!
                       self.performSegue(withIdentifier: "RolController", sender: self)
                       
                   }
                   return [updateAction]
               }
               return nil
               
    }
    
    func updateUI(){
            var result = RolViewModel.GetAll()
            rol.removeAll()
            if result.Correct!{
                for objRol in result.Objects!{
                    let roles = objRol as! Rol //Unboxing
                    rol.append(roles)
                }
                
                tableView.reloadData()
                
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               //controlar que hacer antes de ir a la siguiente vista
               if segue.identifier == "RolController"{
                   let formControl = segue.destination as! RollViewController
                   formControl.IdRol = self.IdRol
                   
               }
           }

}

