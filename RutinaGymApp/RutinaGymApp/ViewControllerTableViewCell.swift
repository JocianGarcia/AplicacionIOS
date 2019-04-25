//
//  ViewControllerTableViewCell.swift
//  RutinaGymApp
//
//  Created by Mike on 4/24/19.
//  Copyright © 2019 UTNG. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMuscle: UILabel!
    @IBOutlet weak var lblExercise: UILabel!
    @IBOutlet weak var lblRepetitions: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
