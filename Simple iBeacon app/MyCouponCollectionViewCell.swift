//
//  MyCouponCollectionViewCell.swift
//  Simple iBeacon app
//
//  Created by Paritosh Sharma on 13/01/17.
//  Copyright © 2017 Alphanso Tech. All rights reserved.
//

import UIKit

class MyCouponCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgCoupon: UIImageView!
    
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var lblInStorePrice: UILabel!
    @IBOutlet weak var lblCouponPrice: UILabel!
}
