//
//  adminlistcell.swift
//  MyLostChild
//
//  Created by Creative Empire on 4/27/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit

class adminlistcell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
