//
//  ArchiveCell.swift
//  MyWellness
//
//  Created by Justin Ong on 8/13/22.
//

import UIKit

class ArchiveCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var happinessLevel: UILabel!
    @IBOutlet weak var mood: UIImageView!
    @IBOutlet weak var cardio: UIImageView!
    @IBOutlet weak var meditation: UIImageView!
    @IBOutlet weak var exercise: UIImageView!
    @IBOutlet weak var nutrition: UIImageView!
    @IBOutlet weak var misc: UIImageView!
    @IBOutlet weak var sleep: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
