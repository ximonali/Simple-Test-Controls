//
//  ViewController.swift
//  LoginApp
//
//  Created by macadmin on 2016-03-11.
//  Copyright (c) 2016 macadmin. All rights reserved.
//

import UIKit

class Login: UIViewController {

    //Var
    var userFlag: Bool = false;
    var localUser: String = "simon";
    var localPass: String = "12345";
    
    
    //Label
    
    @IBOutlet weak var lblMsg: UILabel!

    
    //Button
    
    @IBAction func btnLogin(_ sender: UIButton) {
        if (checkUser()) {
            userFlag = false;
            self.performSegue(withIdentifier: "go2WelcomeVC", sender: self)
            txtName.text = "";
            txtPassword.text = "";
            
        }
    
    }
    
    //Text
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    //Image
    
    @IBOutlet weak var ImageView: UIImageView!
    
    //PopUp Msg
    func errorPopUp(_ msgError: String){
        let msgError = msgError
        
        let test = UIAlertController(title: "Authentication Error", message: msgError, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil)
            //{UIAlertAction in NSLog("Si quiero mandar hacer algo aqui")}
        
        //var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            //UIAlertAction in NSLog("OK Pressed")}
        
        test.addAction(cancelAction);
        //test.addAction(okAction);
        
        self.present(test, animated: true, completion: nil)
    
        
    }

    
    //---------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false;
        loadMain()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "go2WelcomeVC" {
            let xWelcomeVC = segue.destination as! WelcomeVC;
            var nueva = "";
            nueva = txtName.text!;
            xWelcomeVC.actualUser = txtName.text!;

        }
  
    }// end prepareForSegue
    
    func loadMain(){
        userFlag = false;
        lblMsg.text = "";
        
        ImageView.layer.cornerRadius = ImageView.frame.size.width/2
        ImageView.clipsToBounds = true
        ImageView.contentMode = .scaleToFill
        ImageView.image = UIImage(named: "loginimage")
    
    }//end loadMain
    
    func checkUser()->Bool{
        lblMsg.text = "";
        
        if (!txtName.text!.isEmpty && !txtPassword.text!.isEmpty){
            txtName.backgroundColor = UIColor.white;
            txtPassword.backgroundColor = UIColor.white;
            
            if (txtName.text == localUser && txtPassword.text == localPass){
                userFlag = true;
            }
            else if (txtName.text != localUser && txtPassword.text == localPass){
                //lblMsg.text = "Username did not Match!"
                errorPopUp("Username did not Match!")
            }else if(txtName.text == localUser && txtPassword.text != localPass){
                //lblMsg.text = "Password did not Match!"
                errorPopUp("Password did not Match!")
            }else if(txtName.text != localUser && txtPassword.text != localPass){
                //lblMsg.text = "Username and Password did not Match!"
                errorPopUp("Username and Password did not Match!")
            }

        
        }
        
        else if (txtName.text!.isEmpty && !txtPassword.text!.isEmpty){
            txtName.backgroundColor = UIColor.red;
            txtPassword.backgroundColor = UIColor.white;
            //lblMsg.text = "Username can't be null!"
            errorPopUp("Username can't be null!")
        
        }
        
        else if (!txtName.text!.isEmpty && txtPassword.text!.isEmpty) {
            txtPassword.backgroundColor = UIColor.red;
            txtName.backgroundColor = UIColor.white;
            //lblMsg.text = "Password can't be null!"
            errorPopUp("Password can't be null!")
        }
        
        else if (txtName.text!.isEmpty && txtPassword.text!.isEmpty){
            txtPassword.backgroundColor = UIColor.red;
            txtName.backgroundColor = UIColor.red;
            //lblMsg.text = "Username and Password can't be null!"
            errorPopUp("Username and Password can't be null!")
            
        }
        
    return userFlag
    }//end checkUser
    
    


    
    


}

