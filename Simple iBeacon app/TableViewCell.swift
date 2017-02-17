//
//  TableViewCell.swift
//  Simple iBeacon app
//
//  Created by Paritosh Sharma on 02/01/17.
//  Copyright © 2017 Alphanso Tech. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var beconName: UILabel!
    @IBOutlet weak var bconId: UILabel!
    @IBOutlet weak var beconStatus: UILabel!
    @IBOutlet weak var lblMajor: UILabel!
    @IBOutlet weak var lblMinor: UILabel!
    @IBOutlet weak var lblDistance: UILabel!

    
    
    
    
    
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblAns: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
