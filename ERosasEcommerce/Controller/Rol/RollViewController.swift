//
//  RollViewController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 11/05/23.
//

import UIKit
import SwipeCellKit

class RollViewController: UIViewController {

    
    @IBOutlet weak var txtIdRol: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    
    @IBOutlet weak var lblIdRol: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBOutlet weak var btnAction: UIButton!
    
    var IdRol : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtIdRol.delegate = self
        txtNombre.delegate = self
    
        if IdRol == 0{
                  
                  self.txtIdRol.text = ""
                  self.txtNombre.text = ""
                  //txtIdRol.isHidden = true
                 // lblIdRol.isHidden = true
                  
                  btnAction.backgroundColor = .green
                  btnAction.setTitle("Agregar", for: .normal)
              }else{
                 
                  txtIdRol.isUserInteractionEnabled = false
                  
                  
                  let rol =  RolViewModel.GetByid(IdRol: IdRol)
                  //unboxing
                  let acceder = rol.Object! as! Rol
                              
                  self.txtIdRol.text = acceder.IdRol?.description
                  self.txtNombre.text = acceder.Nombre
                     
                  btnAction.backgroundColor = .yellow
                  btnAction.setTitle("Actualizar", for: .normal)
              }
    }
    
    
    

    
    @IBAction func btnObtenerDatos(_ sender: UIButton) {
                  
              guard txtNombre.text != "" else {
              lblNombre.text = "El campo no puede ser vacio"
              txtNombre.layer.borderColor = UIColor.red.cgColor
              txtNombre.layer.borderWidth = 2
              return
                }
        
                let opcion = btnAction.titleLabel?.text
                switch opcion{
                case "Agregar":
                    var rol = Rol()

                    rol.Nombre = txtNombre.text!
                    
                    let result = RolViewModel.Add(rol: rol)
                    if result.Correct! {

                        let alert = UIAlertController(title: "Mensaje", message: "Rol insertado correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)

                        alert.addAction(action)

                        self.present(alert, animated: true, completion: nil)
                        txtNombre.text! = ""
                    }
                    break
                case "Actualizar":
                    var rol = Rol()
                    
                    rol.IdRol = Int(txtIdRol.text!) ?? 0
                    rol.Nombre = txtNombre.text!

                    let result = RolViewModel.Update(rol: rol)
                    if result.Correct! {
                        let alert = UIAlertController(title: "Mensaje", message: "Rol actualizado correctamente", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil)
                        txtNombre.text! = ""
                    }
                    break
                default:
                    print("Error al actualizar")
                }
        }
    
}
//MARK: UITextFieldDelegate
extension RollViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtNombre.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
      
  
