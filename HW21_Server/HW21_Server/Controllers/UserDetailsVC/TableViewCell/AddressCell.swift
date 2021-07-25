//
//  UserDetailsCell.swift
//  HW21_Server
//
//  Created by Nata on 25.07.2021.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var suite: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zipcode: UILabel!
    
    func configure (with item: User) {
        street.text = item.address?.street
        suite.text = item.address?.suite
        city.text = item.address?.city
        zipcode.text = item.address?.zipcode
    }
}
