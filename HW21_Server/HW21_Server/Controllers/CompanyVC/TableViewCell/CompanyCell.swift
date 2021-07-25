//
//  CompanyCell.swift
//  HW21_Server
//
//  Created by Nata on 25.07.2021.
//

import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var catchPhrase: UILabel!
    @IBOutlet weak var bs: UILabel!
    
    func configure (with item: User) {
        name.text = item.company?.name
        catchPhrase.text = item.company?.catchPhrase
        bs.text = item.company?.bs
    }
}
