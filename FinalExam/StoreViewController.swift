//
//  TableViewController.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/8/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class StoreTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var imageSet = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "10")]
    
    let realm = try! Realm()
    
    @IBOutlet weak var tableView: UITableView!
    var stores = NSMutableArray()
    
    @IBAction func goToFavorite(_ sender: Any) {
    }
    @IBOutlet weak var searchBr: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBr.text {
            view.endEditing(true)
            Request.search(keyword: keyword, {
                (error, json) in
                if (error != nil) {
                    print(error!)
                }
                else {
                    print(json!)
                    self.setStores(storeJson: json!)
                    if (self.stores.count == 0) {
                        self.showAlert(title: "Not Found", text: "please try another keyword")
                    }
                    self.tableView.reloadData()
                    
                }
            })
        }
    }
    
    var storeToShowDetail = Store()
    var indexToSelect = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let store = stores[indexPath.row] as? Store {
            storeToShowDetail = store
            indexToSelect = indexPath.row
            performSegue(withIdentifier: "detailSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if storeToShowDetail.name != "" {
            if segue.identifier == "detailSegue" {
                if let destination = segue.destination as? DetailViewController{
                    destination.setStore(store: storeToShowDetail, img: self.imageSet[indexToSelect])
                }
            }
        }
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! StoreTableViewCell
        // Configure the cell...
        if let store = stores[indexPath.row] as? Store {
            cell.nameLabel.text = store.name
            cell.openLabel.text = "Open: \(store.open)"
            cell.closeLabel.text = "Close: \(store.close)"
            cell.storeImage.image = imageSet[indexPath.row]
            cell.storeType.text = store.type
            
            cell.saveAction = {
                (cell) in
                print("save \(store.name)")
                self.saveFavorite(store: store)
            }
            
        }
        
        return cell
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Request.index({
            (error, json) in
            if (error != nil){
                print(error!)
            }
            else {
                print(json!)
                self.setStores(storeJson: json!)
                self.tableView.reloadData()
            }
        })
    }
    
    func setStores(storeJson: JSON) {
        stores.removeAllObjects()
        let jsonData = storeJson["message"]
        if jsonData != JSON.null{
            for (_, storeJson):(String, JSON) in jsonData {
                let store = getStoreFromJson(json: storeJson )
                
                print("Loaded: \(store.name)")
                stores.add(store)
            }
        }
        else {
            print("No Result")
        }
    }
    
    public func showAlert(title: String, text: String) {
        let alert =  UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getStoreFromJson(json: JSON) -> Store {
        let store = Store()
        
        if let detail = json["detail"].string {
            store.detail = detail
        }
        
        if let address = json["address"].string {
            store.address = address
        }
        
        if let long = json["longtitude"].string {
            store.longitude = long
        }
        
        if let lat = json["latitude"].string {
            store.latitude = lat
        }
        
        if let type = json["type"].string {
            store.type = type
        }
        
        if let tel = json["tel"].string {
            store.tel = tel
        }
        
        if let open = json["open"].string {
            store.open = open
        }
        
        if let close = json["close"].string {
            store.close = close
        }
        
        if let name = json["name"].string {
            store.name = name
        }
        
        return store
    }
    
    func saveFavorite(store: Store) {
        try! realm.write {
            realm.add(store)
        }
    }
}
