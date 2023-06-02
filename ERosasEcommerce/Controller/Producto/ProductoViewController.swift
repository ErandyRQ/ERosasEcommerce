//
//  ProductoViewController.swift
//  ERosasEcommerce
//
//  Created by MacBookMBA9 on 17/05/23.
//

import UIKit
import SwipeCellKit
import iOSDropDown
import SQLite3

class ProductoViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBOutlet weak var txtPrecioUnitario: UITextField!
    
    @IBOutlet weak var lblPrecioUnitario: UILabel!
    
    
    @IBOutlet weak var txtStock: UITextField!
    
    @IBOutlet weak var lblStock: UILabel!
    
    
    @IBOutlet weak var txtDescripcion: UITextField!
    
    @IBOutlet weak var lblDescripcion: UILabel!
    
    
    @IBOutlet weak var ddlArea: DropDown!
    
    @IBOutlet weak var ddlDepartamento: DropDown!
    
    @IBOutlet weak var ddlProveedor: DropDown!
    
    @IBOutlet weak var lblDepartamento: UILabel!
    
    @IBOutlet weak var lblProveedor: UILabel!
    
    @IBOutlet weak var btnGaleria: UIButton!
    
    @IBOutlet weak var btnAction: UIButton!
    
    
    var IdProducto: Int = 0
    var IdProveedor : Int = 0
    var IdDepartamento : Int = 0
    var IdArea : Int = 0
    
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        ddlArea.didSelect { selectedText, index, id in self.IdArea = id}
        
        ddlProveedor.didSelect{ selectedText, index, id in self.IdProveedor = id}
        
        ddlDepartamento.didSelect{ selectedText, index, id in self.IdDepartamento = id}
        
        
        
        //Image delegate
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.isEditing = false
        
        //Drpdown Area
        ddlArea.optionArray = []
        ddlArea.optionIds = []
        
        let resultArea = ProductoViewModel.GetAllArea()
        if resultArea.Correct!{
            for objarea in resultArea.Objects!{
                let area = objarea as! Area
                ddlArea.optionArray.append(area.Nombre!)
                ddlArea.optionIds?.append(area.IdArea!)
            }
        }
        
        //Drpdown Departamento
        ddlDepartamento.optionArray = []
        ddlDepartamento.optionIds = []
        
        let resultDepartamento = ProductoViewModel.GetAllDepartamento()
        if resultDepartamento.Correct!{
            for objdepartamento in resultDepartamento.Objects!{
                let departamento = objdepartamento as! Departamento
                ddlDepartamento.optionArray.append(departamento.Nombre!)
                ddlDepartamento.optionIds?.append(departamento.IdDepartamento!)
            }
        }
        
        //Drpdown Proveedor
        ddlProveedor.optionArray = []
        ddlProveedor.optionIds = []
        
        let resultProveedor = ProductoViewModel.GetAllProveedor()
        if resultProveedor.Correct!{
            for objproveedor in resultProveedor.Objects!{
                let proveedor = objproveedor as! Proveedor
                ddlProveedor.optionArray.append(proveedor.Nombre!)
                ddlProveedor.optionIds?.append(proveedor.IdProveedor!)
            }
        }
        
       
        
        
        
        
        if IdProducto == 0{
        
            btnAction.backgroundColor = .blue
            btnAction.setTitle("Agregar", for: .normal)
            
        }else{
            let producto = ProductoViewModel.GetById(IdProducto: IdProducto)
            
            let datos = producto.Object as! Producto
            
            //self.txtIdProducto.text = datos.IdProducto?.description
            self.txtNombre.text = datos.Nombre
            self.txtPrecioUnitario.text = datos.PrecioUnitario?.description
            self.txtStock.text = datos.Stock?.description
            
            //imagen
            let string = datos.Imagen
            let newImageData = Data(base64Encoded: string!)
            if let newImageData = newImageData {
                self.imageView.image = UIImage(data: newImageData)
            }
            
            //self.imageView.image = UIImage.init(data: 	)
            self.txtDescripcion.text = datos.Descripcion
            self.ddlProveedor.text = datos.Proveedor?.Nombre
            self.ddlDepartamento.text = datos.Departamento?.Nombre
            
            //button
            btnAction.backgroundColor = .magenta
            btnAction.setTitle("Actualizar", for: .normal)
        }
        
        
        
    }
    
    
    @IBAction func onePickerImage() {
        self.present(imagePickerController, animated: true)
    }
    
    
    
    @IBAction func obtenerDatos(_ sender: UIButton) {
        
        //let producto = Producto()
        
       // let imagen = imageView.image
      //  producto.Imagen = convertToBase64()
        
        guard txtNombre.text != "" else {
            lblNombre.text = "El campo no puede ser vacio"
            txtNombre.layer.borderColor = UIColor.red.cgColor
            txtNombre.layer.borderWidth = 2
            return
        }
        
        guard txtPrecioUnitario.text != "" else {
            lblPrecioUnitario.text = "El campo no puede ser vacio"
            txtPrecioUnitario.layer.borderColor = UIColor.red.cgColor
            txtPrecioUnitario.layer.borderWidth = 2
            return
        }
        
        guard txtStock.text != "" else {
            lblStock.text = "El campo no puede ser vacio"
            txtStock.layer.borderColor = UIColor.red.cgColor
            txtStock.layer.borderWidth = 2
            return
        }
        
        guard txtDescripcion.text != "" else {
            lblDescripcion.text = "El campo no puede ser vacio"
            txtDescripcion.layer.borderColor = UIColor.red.cgColor
            txtDescripcion.layer.borderWidth = 2
            return
        }
        
        
        let opcion = btnAction.titleLabel?.text
        switch opcion{
        case "Agregar":
            var producto = Producto()
            
            producto.Nombre = txtNombre.text!
            producto.PrecioUnitario = Int(txtPrecioUnitario.text!)
            producto.Stock = Int(txtStock.text!)
            producto.Descripcion = txtDescripcion.text!
            producto.Imagen = convertToBase64()
            
            producto.Proveedor = Proveedor()
            producto.Proveedor?.IdProveedor = self.IdProveedor
            producto.Departamento = Departamento()
            producto.Departamento?.IdDepartamento = self.IdDepartamento
            
            let result = ProductoViewModel.Add(producto: producto)
            
            
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Producto agregado", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
                
                //txtIdProducto.text! = ""
                txtNombre.text! = ""
                txtPrecioUnitario.text! = ""
                txtStock.text! = ""
                txtDescripcion.text! = ""
                //ImageView.image =
                ddlProveedor.text! = ""
                ddlDepartamento.text! = ""
                
            }
            break
        case "Actualizar":
            var producto = Producto()
            
            producto.IdProducto = IdProducto//Int(txtIdProducto.text!) ?? 0
            producto.Nombre = txtNombre.text!
            producto.PrecioUnitario = Int(txtPrecioUnitario.text!)
            producto.Stock = Int(txtStock.text!)
            producto.Descripcion = txtDescripcion.text!
            producto.Imagen = convertToBase64()
            
            producto.Proveedor = Proveedor()
            producto.Proveedor?.IdProveedor = self.IdProveedor
            
            producto.Departamento = Departamento()
            producto.Departamento?.IdDepartamento = self.IdDepartamento
            
            
            let result = ProductoViewModel.Update(producto: producto)
            if result.Correct! {
                let alert = UIAlertController(title: "Mensaje", message: "Producto actualizado", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
                
                //txtIdProducto.text! = ""
                txtNombre.text! = ""
                txtPrecioUnitario.text! = ""
                txtStock.text! = ""
                txtDescripcion.text! = ""
                ddlProveedor.text! = ""
                ddlDepartamento.text! = ""
                
            }
            break
        default:
            print("No se esogio una opción")
        }
    }
    
    
}
    

// MARK: ImageView
extension ProductoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let data = info[.originalImage]
        self.imageView.image = info[.originalImage] as! UIImage
        
        dismiss(animated: true)
    }
    func convertToBase64 () -> String{
        let base64 = (imageView.image?.pngData()?.base64EncodedString())!
        return base64
    }
    
}
