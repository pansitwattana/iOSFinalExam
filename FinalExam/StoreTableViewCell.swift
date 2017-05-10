//
//  StoreTableViewCell.swift
//  FinalExam
//
//  Created by Pansit Wattana on 5/9/17.
//  Copyright © 2017 Pansit Wattana. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var storeType: UILabel!
    @IBOutlet weak var storeImage: UIImageView!
    
    var saveAction: ((UITableViewCell) -> Void)?

    @IBAction func saveClick(_ sender: Any) {
        saveAction?(self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
