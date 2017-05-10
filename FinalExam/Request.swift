//
//  Request.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/9/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Request {
    
    static func index(_ completion: @escaping (_ error: NSError?, _ json: JSON?) -> Void) {
        
        let url = "http://a-ning.banana.co.th/final/index.php"
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if urlString != nil {
            Alamofire.request(urlString!).validate().responseJSON { (response) in
                do {
                    let searchJson = JSON(data: response.data!)
                    let error = response.error
                    completion(error as NSError?, searchJson)
                }
            }
        }
        else {
            print(url + " is not valid")
        }
    }
    
    static func search(keyword: String, _ completion: @escaping (_ error: NSError?, _ json: JSON?) -> Void) {
        
        let url = "http://a-ning.banana.co.th/final/index.php?name=\(keyword)"
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if urlString != nil {
            Alamofire.request(urlString!).validate().responseJSON { (response) in
                do {
                    let searchJson = JSON(data: response.data!)
                    let error = response.error
                    completion(error as NSError?, searchJson)
                }
            }
        }
        else {
            print(url + " is not valid")
        }
    }
}
