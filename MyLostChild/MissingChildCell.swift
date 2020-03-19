//
//  MissingChildCell.swift
//  MyLostChild
//
//  Created by Creative Empire on 4/27/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit

class MissingChildCell: UITableViewCell {

    @IBOutlet weak var childimage: UIImageView!
    @IBOutlet weak var morebutton: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var age: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    @IBAction func moreaction(_ sender: Any) {
        
   
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
