//
//  RegistroViewController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 22/05/23.
//

import UIKit
import Firebase

class RegistroViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    @IBOutlet weak var txtValidarPassword: UITextField!
    
    @IBOutlet weak var lblValidarPassword: UILabel!
    
    @IBOutlet weak var btnCrearCuenta: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func crearCuenta() {
        
        guard txtEmail.text != "" else {
            txtEmail.text =  "El campo no puede ser vacio"
            txtEmail.layer.borderColor = UIColor.red.cgColor
            txtEmail.layer.borderWidth = 2
            return
        }
        
        guard txtPassword.text != "" else {
            txtPassword.text =  "El campo no puede ser vacio"
            txtPassword.layer.borderColor = UIColor.red.cgColor
            txtPassword.layer.borderWidth = 2
            return
        }
        
        guard txtValidarPassword.text != "" else {
            txtValidarPassword.text =  "El campo no puede ser vacio"
            txtValidarPassword.layer.borderColor = UIColor.red.cgColor
            txtValidarPassword.layer.borderWidth = 2
            return
        }
        
        guard txtPassword.text == txtValidarPassword.text else{
                
            lblValidarPassword.text = "No coinciden las contraseñas"
            txtPassword.layer.borderColor = UIColor.red.cgColor
            txtPassword.layer.borderWidth = 2
            return
        }

        
        let email = txtEmail.text!
        let password = txtPassword.text!
        
                
                Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
                            guard let strongSelf = self else{return}
                
          
            if let correct = authResult{
                
                let alert = UIAlertController(title: "Mensaje", message: "Usuario Registrado", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
                
                self!.txtEmail.text! = ""
                self!.txtPassword.text! = ""
                self!.txtValidarPassword.text! = ""
                
                self?.performSegue(withIdentifier: "ControllerInicio", sender: self)
                
            }
            
        }
        
        
    }
    }
    


