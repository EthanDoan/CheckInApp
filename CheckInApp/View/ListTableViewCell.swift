//
//  ListTableViewCell.swift
//  CheckInApp
//
//  Created by Doan Van Phuong on 12/30/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(name: String, position: String, id: String, time: String) {
        nameLabel.text = name
        positionLabel.text = position
        idLabel.text = id
        timeLabel.text = time
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
