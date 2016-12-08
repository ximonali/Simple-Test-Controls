//
//  FavoriteVC.swift
//  
//
//  Created by macadmin on 2016-03-16.
//
//

import UIKit

class FavoriteVC: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    //Para mi search bar
    var filteredName = [String] ()
    var searchActive = false
    
    
    var myFavoriteArray: [String] = [];
    
    @IBOutlet weak var myTableViewFavorite: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableViewFavorite.delegate = self;
        myTableViewFavorite.dataSource = self;
        searchBar.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    // Para mi TABLE VIEW
    
    
    //1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countNum = 0;
        if searchActive {
            countNum = filteredName.count
        }else
        {
            countNum = myFavoriteArray.count
        }
        
        return countNum
    }
    
    //2
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
     
        return 1
    }
    
    //3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell2", for: indexPath) as! TableViewCell2
        
        //globalIndex = indexPath.row;
        
        print("Row Of  :\((indexPath as NSIndexPath).row)")
        
        if searchActive {
            cell.textLabel?.text = filteredName[(indexPath as NSIndexPath).row]
            
        }else
        {
            
            cell.textLabel?.text = myFavoriteArray[(indexPath as NSIndexPath).row]
            
        }
        
       //cell.lblFavorite.text = myFavoriteArray[indexPath.row]
    return cell
    }
    
    //4
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //println(globalIndex);
        
    }


    /* Search Bar Code Start */
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("searchBar  textDidChange Calling ")
        
        
        if(searchBar.text!.isEmpty) {
            
            self.searchActive = false
            
        } else {
            
            filteredName.removeAll(keepingCapacity: false)
            
            for index in (0 ..< myFavoriteArray.count) {
                
                let name = myFavoriteArray[index]
                
                if( name.lowercased().range(of: searchText.lowercased()) != nil ){
                    
                    filteredName.append(name)
                    self.searchActive = true
                }
                
            }
        }
        
        self.myTableViewFavorite!.reloadData()
    }
    
    
    
    

}
