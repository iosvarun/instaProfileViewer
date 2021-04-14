//
//  InAppTableViewCell.swift
//  DirectMessage
//
//  Created by Varun Kumar on 07/04/21.
//

import UIKit

class InAppTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        title.textColor = Theme.color(ColorCustomization.textColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(inAppCellModel: InAppCellModel) {
        title.text = inAppCellModel.title
    }
    
}
