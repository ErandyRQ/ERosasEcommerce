//
//  ViewController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 28/04/23.
//

import UIKit
import SwipeCellKit
import iOSDropDown

class ViewController: UIViewController {
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblApellidoP: UILabel!
    
    @IBOutlet weak var lblApellidoM: UILabel!
    
    @IBOutlet weak var lblFecha: UILabel!
    
    @IBOutlet weak var lblUsername: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    
    
    @IBOutlet weak var btnAction: UIButton!
    
    
    @IBOutlet weak var txtIdUsuarioOutlet: UITextField!
    
    @IBOutlet weak var txtNombreOutlet: UITextField!
    
    @IBOutlet weak var txtApellidoPaternoOutlet: UITextField!
    
    @IBOutlet weak var txtApellidoMaternoOutlet: UITextField!
    
    @IBOutlet weak var txtFechaNacimientoOutlet: UITextField!
    
    @IBOutlet weak var txtUsernameOutlet: UITextField!
    
    @IBOutlet weak var txtPasswordOutlet: UITextField!
    
    @IBOutlet weak var ddlRol: DropDown!
    
    
    var IdUsuario : Int  = 0
    var IdRol : Int = 0
    
  
    
    override func viewDidLoad() {
        
        ddlRol.didSelect{ selectedText, index, id in self.IdRol = id}
        
        super.viewDidLoad()
        
        ddlRol.optionArray = []
        ddlRol.optionIds = []
        
        let resultRol = RolViewModel.GetAll()
        if resultRol.Correct!{
            for objrol in resultRol.Objects!{
                let rol = objrol as! Rol
                //agregamos los datos de la bd en los arrays
                ddlRol.optionArray.append(rol.Nombre!)
                ddlRol.optionIds?.append(rol.IdRol!)
            }
        }
                
                if IdUsuario == 0{
                    
                    btnAction.backgroundColor = .green
                    btnAction.setTitle("Agregar", for: .normal)
                    
               }else{
                   let usuario = UsuarioViewModel.GetById(IdUsuario: IdUsuario)
                   
                   let datos = usuario.Object as! Usuario
                   
                   self.txtIdUsuarioOutlet.text = datos.IdUsuario?.description
                   self.txtNombreOutlet.text = datos.Nombre
                   self.txtApellidoPaternoOutlet.text = datos.ApellidoPaterno
                   self.txtApellidoMaternoOutlet.text = datos.ApellidoMaterno
                   self.txtFechaNacimientoOutlet.text = datos.FechaNacimiento
                   self.txtUsernameOutlet.text = datos.Username
                   self.txtPasswordOutlet.text = datos.Password
                   self.ddlRol.text = datos.Rol?.Nombre
                   
                   btnAction.backgroundColor = .yellow
                   btnAction.setTitle("Actualizar", for: .normal)
             }
        
    }
    
    
    
    @IBAction func ActionButons(_ sender: UIButton) {
        
        guard txtNombreOutlet.text != "" else {
              lblNombre.text = "El campo no puede ser vacio"
              txtNombreOutlet.layer.borderColor = UIColor.red.cgColor
              txtNombreOutlet.layer.borderWidth = 2
              return
                }

        guard txtApellidoPaternoOutlet.text != "" else {
              lblApellidoP.text = "El campo no puede ser vacio"
              txtApellidoPaternoOutlet.layer.borderColor = UIColor.red.cgColor
              txtApellidoPaternoOutlet.layer.borderWidth = 2
              return
                }
        
        guard txtApellidoMaternoOutlet.text != "" else {
              lblApellidoM.text = "El campo no puede ser vacio"
              txtApellidoMaternoOutlet.layer.borderColor = UIColor.red.cgColor
              txtApellidoMaternoOutlet.layer.borderWidth = 2
              return
                }
        
        guard txtFechaNacimientoOutlet.text != "" else {
              lblFecha.text = "El campo no puede ser vacio"
              txtFechaNacimientoOutlet.layer.borderColor = UIColor.red.cgColor
              txtFechaNacimientoOutlet.layer.borderWidth = 2
              return
                }
        
        guard txtUsernameOutlet.text != "" else {
              lblUsername.text = "El campo no puede ser vacio"
              txtUsernameOutlet.layer.borderColor = UIColor.red.cgColor
              txtUsernameOutlet.layer.borderWidth = 2
              return
                }
        
        guard txtPasswordOutlet.text != "" else {
              lblPassword.text = "El campo no puede ser vacio"
              txtPasswordOutlet.layer.borderColor = UIColor.red.cgColor
              txtPasswordOutlet.layer.borderWidth = 2
              return
                }
        
        let opcion = btnAction.titleLabel?.text
                switch opcion{
                case "Agregar":
                    var usuario = Usuario()
                    
                    usuario.Nombre = txtNombreOutlet.text!
                    usuario.ApellidoPaterno = txtApellidoPaternoOutlet.text!
                    usuario.ApellidoMaterno = txtApellidoMaternoOutlet.text!
                    usuario.FechaNacimiento = txtFechaNacimientoOutlet.text!
                    usuario.Username = txtUsernameOutlet.text!
                    usuario.Password = txtPasswordOutlet.text!
                    
                    usuario.Rol = Rol()
                    usuario.Rol?.IdRol = self.IdRol
                    
                    let result = UsuarioViewModel.Add(usuario: usuario)
                    if result.Correct! {
                        let alert = UIAlertController(title: "Mensaje", message: "Usuario Agregado", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        alert.addAction(action)
                        self.present(alert,animated: true,completion: nil)
                        
                        txtIdUsuarioOutlet.text! = ""
                        txtNombreOutlet.text! = ""
                        txtApellidoPaternoOutlet.text! = ""
                        txtApellidoMaternoOutlet.text! = ""
                        txtFechaNacimientoOutlet.text! = ""
                        txtUsernameOutlet.text! = ""
                        txtPasswordOutlet.text! = ""
                        ddlRol.text! = ""
                    }
                    break
                case "Actualizar":
                    var usuario = Usuario()
                    
                    usuario.IdUsuario = Int(txtIdUsuarioOutlet.text!) ?? 0
                    usuario.Nombre = txtNombreOutlet.text!
                    usuario.ApellidoPaterno = txtApellidoPaternoOutlet.text!
                    usuario.ApellidoMaterno = txtApellidoMaternoOutlet.text!
                    usuario.FechaNacimiento = txtFechaNacimientoOutlet.text!
                    usuario.Username = txtUsernameOutlet.text!
                    usuario.Password = txtPasswordOutlet.text!
                    
                    usuario.Rol = Rol()
                    usuario.Rol?.IdRol = self.IdRol
                
                    
                    let result = UsuarioViewModel.Update(usuario: usuario)
                    if result.Correct! {
                        let alert = UIAlertController(title: "Mensaje", message: "Usuario actualizado", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default)
                        alert.addAction(action)
                        self.present(alert,animated: true,completion: nil)
                        
                        txtIdUsuarioOutlet.text! = ""
                        txtNombreOutlet.text! = ""
                        txtApellidoPaternoOutlet.text! = ""
                        txtApellidoMaternoOutlet.text! = ""
                        txtFechaNacimientoOutlet.text! = ""
                        txtUsernameOutlet.text! = ""
                        txtPasswordOutlet.text! = ""
                        ddlRol.text! = ""
                    }
                    break
                default:
                    print("No se realizo nada")
                }
    }
    
}

