//
//  CoreDataTableViewCell.swift
//  Interviewing
//
//  Created by Алексей on 15.01.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ManTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    @IBOutlet weak var labelFIO: UILabel!
    
    @IBOutlet weak var labelBirthday: UILabel!
    
    var man: Man?
    
    func setCell(man: Man){
        self.man = man
        labelFIO.text = "\(man.lastname!) \(man.firstname!)"
        labelBirthday.text = man.birthday?.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
