//
//  LoginViewController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 19/05/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnAcceso: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func btnAcceder() { //No lleva el sender y tampoco los dos de abajo  _ sender: Any
      //  self.btnAcceder("Crash")
      //  fatalError("Chrash")
        
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
        
        
        
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            
            if let ex = error{
                let alert = UIAlertController(title: "Mensaje", message: "Email o contraseña incorrectas", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self!.present(alert, animated: true, completion: nil)
                
                self!.txtEmail.text! = ""
                self!.txtPassword.text! = ""
            }
            if let correct = authResult{
                self?.performSegue(withIdentifier: "LoginController", sender: self)
            }
            
        }
        
        
    }
}
