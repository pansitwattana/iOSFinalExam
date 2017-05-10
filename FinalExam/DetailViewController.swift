//
//  DetailViewController.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/9/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var store = Store()
    var img: UIImage!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var lat = ""
    var long = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = store.name
        storeImage.image = img
        openLabel.text = "Open: \(store.open)"
        closeLabel.text = "Close: \(store.close)"
        telLabel.text = "Tel: \(store.tel)"
        detailTextView.text = store.detail
        lat = store.latitude
        long = store.longitude
    }
    @IBAction func seeMap(_ sender: Any) {
        let url = URL(string: "https://www.google.com/maps?q=\(store.latitude),\(store.longitude)")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setStore(store: Store, img: UIImage) {
        print(store.name)
        self.store = store
        self.img = img
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "mapSegue" {
//            if let destination = segue.destination as? MapViewController{
//                if let latitude = Double(self.lat) {
//                    if let longtitude = Double(self.long) {
//                        destination.setLocation(lat: latitude, long: longtitude)
//                    }
//                }
//                
//            }
//        }
    }
    
    
    

}
