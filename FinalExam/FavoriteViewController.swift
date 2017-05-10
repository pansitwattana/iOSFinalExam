//
//  FavoriteViewController.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/9/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let realm = try! Realm()
    let results = try! Realm().objects(Store.self)
    @IBOutlet weak var tableView: UITableView!
    var imageSet = [#imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "10")]
    
    var notificationToken: NotificationToken?
    
    var stores = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
        let stores = try! Realm().objects(Store.self)
        for store in stores {
            self.stores.add(store)
            print(store.name)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tableView.register(StoreTableViewCell.self, forCellReuseIdentifier: "storeCell")
        
        self.notificationToken = results.addNotificationBlock { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self.tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the TableView
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
                break
            case .error(let err):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(err)")
                break
            }
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! StoreTableViewCell
        // Configure the cell...
        if let store = stores[indexPath.row] as? Store{
            cell.nameLabel.text = store.name
            cell.openLabel.text = "Open: \(store.open)"
            cell.closeLabel.text = "Close: \(store.close)"
            cell.storeImage.image = imageSet[indexPath.row % 10]
            cell.storeType.text = store.type
            
            cell.saveAction = {
                (cell) in
                print("save \(store.name)")
                self.delFavorite(store: store, indexPath: indexPath)
            }
            
        }
        
        return cell
    }
    
    func delFavorite(store: Store, indexPath: IndexPath) {
        
        
        realm.beginWrite()
        if let store = stores[indexPath.row] as? Store{
            realm.delete(store)
            stores.removeObject(at: indexPath.row)
            tableView.reloadData()
        }
        try! realm.commitWrite()
        
    }
    
}
