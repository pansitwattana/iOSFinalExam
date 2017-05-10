//
//  RealmTestViewController.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/8/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//

import UIKit
import RealmSwift

class RealmTestViewController: UIViewController {
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addDog(_ sender: Any) {
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("name of dog: \(myDog.name), age \(myDog.age) added")
        
        // Persist your data easily
        try! realm.write {
            realm.add(myDog)
        }
    }
    
    @IBAction func viewDog(_ sender: Any) {
        let puppies = realm.objects(Dog.self)
        for puppy in puppies {
            print("\(puppy.name), \(puppy.age)")
        }
    }
    
    @IBOutlet weak var searchDog: UIButton!
    
    @IBAction func searchDog(_ sender: Any) {
        
        // Query and update from any thread
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theDog = realm.objects(Dog.self).filter("name == 'test'").first
                if theDog != nil {
                    try! realm.write {
                        theDog!.age += 1
                    }
                }
            }
        }
    }
}
