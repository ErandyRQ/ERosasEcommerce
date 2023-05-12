//
//  GetAllUsuarioController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 03/05/23.
//

import UIKit
import SwipeCellKit

class GetAllUsuarioController: UITableViewController{
    
    var usuarios : [Usuario] = []
    var IdUsuario : Int = 0
        
    let dbManager = DBManager()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "UsuarioCell", bundle: .main), forCellReuseIdentifier:"UsuarioCell")
        updateUI()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usuarios.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsuarioCell", for: indexPath) as! UsuarioCell
        
        cell.delegate = self
        
        cell.lblNombre.text = usuarios[indexPath.row].Nombre
        cell.lblApellidoP.text = usuarios[indexPath.row].ApellidoPaterno
        cell.lblApellidoM.text = usuarios[indexPath.row].ApellidoMaterno
        cell.lblFechaN.text = usuarios[indexPath.row].FechaNacimiento
        cell.lblRol.text = usuarios[indexPath.row].Rol?.Nombre
        
       
       // print("El index actual es: \(indexPath.row)")
       //cell.textLabel?.text = usuarios[indexPath.row].ApellidoPaterno

        return cell
    }


}
extension GetAllUsuarioController : SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                let result = UsuarioViewModel.Delete(IdUsuario: self.usuarios[indexPath.row].IdUsuario!)
                
                if result.Correct!{
                    print("Usuario ingresado")
                    self.updateUI()
                }else{
                    print("Ocurrio un error")
                }
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                self.IdUsuario = self.usuarios[indexPath.row].IdUsuario!
                self.performSegue(withIdentifier: "ViewController", sender: self)
            }
            return [updateAction]
        }
        return nil
    }
    func updateUI(){
        var result = UsuarioViewModel.GetAll()
        usuarios.removeAll()
        if result.Correct!{
            for objUsuario in result.Objects!{
                let usuario = objUsuario as! Usuario //Unboxing
                usuarios.append(usuario)
            }
            tableView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //controlar que hacer antes de ir a la siguiente vista
        if segue.identifier == "ViewController"{
            let formControl = segue.destination as! ViewController
            formControl.IdUsuario = self.IdUsuario
            
        }
        
        
    }
    
}
