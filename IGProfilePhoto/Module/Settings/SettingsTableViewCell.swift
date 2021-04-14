//
//  SettingsTableViewCell.swift
//  DirectMessage
//
//  Created by MOHIT PAREEK on 29/12/20.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sepratorLineLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        sepratorLineLbl.backgroundColor = Theme.color(ColorCustomization.lightBgColor)
        title.textColor = Theme.color(ColorCustomization.textColor)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(settingModel: SettingModel) {
        title.text = settingModel.title
    }
    
}
