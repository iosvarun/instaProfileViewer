//
//  HistoryTableViewCell.swift
//  DirectMessage
//
//  Created by MOHIT PAREEK on 29/12/20.
//

import UIKit
import SwipeCellKit
class HistoryTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var numberTitleLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var sepratorLineLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell() {
        sepratorLineLbl.backgroundColor = Theme.color(ColorCustomization.lightBgColor)
        numberTitleLbl.textColor = Theme.color(ColorCustomization.textColor)
        messageLbl.textColor = Theme.color(ColorCustomization.lightBgColor)
    }
    
//    func configureCell(historyObj: MessageHistory) {
//        numberTitleLbl.text = historyObj.phoneNumber
//        messageLbl.text = historyObj.messageTxt
//        print("historyObj \(String(describing: historyObj.messageTimeStamp))")
//        print("historyObj \(String(describing: historyObj.messageId))")
//
//    }
    
}
