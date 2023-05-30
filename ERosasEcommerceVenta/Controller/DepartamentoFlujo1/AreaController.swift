import UIKit

class AreaController: UIViewController {
    
    
    @IBOutlet weak var btnBuscar: UIButton!
    
    
    @IBOutlet weak var txtBuscar: UITextField!
    
    @IBOutlet weak var lblError: UILabel!
    
    @IBOutlet weak var collectionArea: UICollectionView!
    
    var area : [Area] = []
    var IdArea : Int = 0
    var Id : Int = 0
    var cadena : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionArea.register(UINib(nibName: "AreaCell", bundle: .main), forCellWithReuseIdentifier: "AreaCell")
        collectionArea.delegate = self
        collectionArea.dataSource = self
        updateUI()
    }
    
    
    @IBAction func BuscarProducto() {
        
        guard txtBuscar.text != "" else {
            lblError.text =  "El campo no puede ser vacio"
            txtBuscar.layer.borderColor = UIColor.red.cgColor
            txtBuscar.layer.borderWidth = 2
            return
        }
        
        cadena = txtBuscar.text!
        
        self.performSegue(withIdentifier: "BuscarProducto", sender: self)
    }
        
        
    }


extension AreaController :  UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return area.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCell", for: indexPath) as! AreaCell
        cell.lblNombre.text = area[indexPath.row].Nombre
        
        
        
        
        if area[indexPath.row].Nombre ==  area[indexPath.row].Nombre {
            cell.imageView.image = UIImage(named: "\(area[indexPath.row].Nombre!)")
        }else{
            //let imagenData : Data = //Proceso inverso de base64 a Data
            //cell.imageView.image = UIImage(data: imagenData)
        }
        return cell
    }
    
    func updateUI(){
        var result = AreaViewModel.GetAll()
        area.removeAll()
        if result.Correct!{
            for objarea in result.Objects!{
                let resultado = objarea as! Area //Unboxing
                area.append(resultado)
            }
            collectionArea.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("seleciono \(area[indexPath.row].IdArea)")
        Id = area[indexPath.row].IdArea!
        print(Id)
        self.performSegue(withIdentifier: "CollectionDepto", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               //controlar que hacer antes de ir a la siguiente vista
               if segue.identifier == "CollectionDepto"{
                   let formControl = segue.destination as! DeptoCollectionController
                   formControl.IdArea = Id
                   
               }else{
                   let formcontrol1 = segue.destination as! ProductoCollectionController
                   formcontrol1.palabra = cadena
               }

           }
}

