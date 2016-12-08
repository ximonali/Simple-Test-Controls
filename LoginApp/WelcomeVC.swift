//
//  WelcomeVC.swift
//  
//
//  Created by macadmin on 2016-03-11.
//
//

import UIKit

class WelcomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

   
    //Var
        var globalIndex: Int = 0;
        var actualUser: String = "";
        var catSelected: String = "";
    
        var categoryArray: [String] = ["Computer","Phones","TVs"];
        var TableArray: [String] = [];
        var addFavoriteArray: [String] = [];
        var itemComputers: [String] = ["Compact","Lenovo","Asus","HP","DELL"];
        var itemPhones: [String] = ["Apple","Samsung","Sonny","Blackberry","Google"];
        var itemTVs: [String] = ["Samsung","LG","Panasonic","Sonny","Vizio"];
    //Label
    
    @IBOutlet weak var resultLbl: UILabel!

    
    
    //Button
    
    
    //DTPicketView
    @IBOutlet weak var categogyPKView: UIPickerView!

    @IBOutlet weak var MyTableVC: UITableView!
    
    
    //Image
    
    @IBOutlet weak var imgUser: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        MyTableVC.delegate = self;
        MyTableVC.dataSource = self;

        categogyPKView.delegate = self;
        categogyPKView.dataSource = self;
        
        self.navigationController?.isNavigationBarHidden = false
        resultLbl.text = "Welcome:  \(actualUser)";
        imgUser.layer.cornerRadius = imgUser.frame.size.width/2
        imgUser.clipsToBounds = true
        imgUser.contentMode = .scaleToFill
        imgUser.image = UIImage(named: "loginimage")
        LoadMyMenuBar();
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func LoadMyMenuBar(){
    
        //self.navigationController?.navigationBarHidden = false
        self.navigationItem.title = "Welcome:  \(actualUser)";
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.red]
        self.navigationController?.navigationBar.tintColor = UIColor.black; //Menu leters Color
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.orange;// background color (alone FADE EFFECT)
        //self.navigationController?.navigationBar.barTintColor = UIColor.yellowColor(); //Bar color SOLID = to background color
        
        //CREANDO BOTONES Y ADICIONANDOLOS A LA BARRA
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Favorites", style: UIBarButtonItemStyle.plain, target: self, action: #selector(WelcomeVC.addFavorite(_:)))
        // AQUI SE PUEDE JUGAR CON UIBarButtonSystemItem.OTRACOSA y oobtener mas botones
        
        //var rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchTapped:")
        
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem], animated: true)
        
    
    }
    
    func addFavorite(_ sender: UIBarButtonItem){
        
        resultLbl.text = "Call from Favorite ButtonBar"
        self.performSegue(withIdentifier: "go2Favorite", sender: self)
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "go2Favorite" {
    let xFavoriteVC = segue.destination as! FavoriteVC;
    var nueva = "";
    //nueva = txtName.text;
    xFavoriteVC.myFavoriteArray = addFavoriteArray;
    
    }
    
    }// end prepareForSegue
    
    
    
    
    // ESTO LO NECESITO PARA EL DTPICKERVIEW
    
    //1 aqui digo la cantidad de componentes en el PKview (SECCIONES o Cantidad de Componentes)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1;
    }
    
    //2 aqui retorno la cantidad de mi arreglo (tamano)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return categoryArray.count;
    }
    
    //3 Aqui muestro lo que tiene mi array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return categoryArray[row];
    }
    
    //4 AQUI Selecciono el valor
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let value = categoryArray[row];
        
        catSelected = value;
        
        if (catSelected == "Computer") {
            
            TableArray = itemComputers
            
        }else if (catSelected == "Phones"){
            TableArray = itemPhones
            
        }else{ //TVs
            TableArray = itemTVs
        
        }
        
        self.MyTableVC.reloadData();
        
    }
    

    
    // Para mi TABLE VIEW
    
    
    //1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    //2
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
        
        //globalIndex = indexPath.row;
        
        cell.lblItem.text = TableArray[(indexPath as NSIndexPath).row]
        cell.btnAdd.addTarget(self, action: #selector(WelcomeVC.addToMyFav(_:)), for: UIControlEvents.touchDown)
        cell.btnAdd.tag = (indexPath as NSIndexPath).row;
        return cell
    }
    
    //4
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //println(globalIndex);
        
    }

    func addToMyFav (_ sender: UIButton){
        //println("Toco Boton! index:  \(sender.tag)")
        
        let msgError: String = TableArray[sender.tag];
        
        let addFav = UIAlertController(title: "Add to Favorites?", message: msgError, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive)
        {
            UIAlertAction in
            //println("Dont Add")
        
        }
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            
        UIAlertAction in
            self.addFavoriteArray.append(self.TableArray[sender.tag]);
           //println("Added")
            
        }
        
        addFav.addAction(cancelAction);
        addFav.addAction(okAction);
        
        self.present(addFav, animated: true, completion: nil)


    }
    

}


