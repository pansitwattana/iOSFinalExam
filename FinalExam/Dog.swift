//
//  Dog.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/8/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//

import Foundation
import RealmSwift

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
}
class Person: Object {
    dynamic var name = ""
    let dogs = List<Dog>()
}
