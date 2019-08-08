//
//  TableCell.swift
//  LocalJson
//
//  Created by QUADRANT on 4/24/19.
//  Copyright © 2019 QUADRANT. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {

    
    @IBOutlet weak var nameLBL: UILabel!
    
    @IBOutlet weak var ageLBL: UILabel!
    
    @IBOutlet weak var employedLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
