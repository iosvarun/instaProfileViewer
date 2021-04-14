//
//  DetailedHistoryTableViewCell.swift
//  DirectMessage
//
//  Created by MOHIT PAREEK on 14/01/21.
//

import UIKit

class DetailedHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageView: RoundedView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var triangleView: UIView!
    @IBOutlet weak var typeOfMessageImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var typeOfMessage: TypeOfMessage?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if typeOfMessage == .whatsapp {
            messageView.backgroundColor = Theme.color(ColorCustomization.lightGreen)
            drawTriangle(Color: Theme.color(ColorCustomization.lightGreen))
            typeOfMessageImage.image = UIImage(named: "whatsapp")
        } else {
            messageView.backgroundColor = Theme.color(ColorCustomization.lightBlue)
            drawTriangle(Color: Theme.color(ColorCustomization.lightBlue))
            typeOfMessageImage.image = UIImage(named: "textMessage")
        }
        messageLabel.textColor = Theme.color(ColorCustomization.textColor)
        dateLabel.textColor = Theme.color(ColorCustomization.textColor)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func drawTriangle(Color: UIColor){
        let width = triangleView.frame.size.width
        let path = CGMutablePath()
        
        path.move(to: CGPoint(x: width/2, y: width/2))
        path.addLine(to: CGPoint(x:width, y: width/2))
        path.addLine(to: CGPoint(x:width, y:width))
        path.addLine(to: CGPoint(x:width/2, y:width/2))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = Color.cgColor
        triangleView.layer.insertSublayer(shape, at: 0)
    }
    
//    func configureCell(typeOfMessage: TypeOfMessage, historyObj: MessageHistory) {
//        if typeOfMessage == .whatsapp {
//            messageView.backgroundColor = Theme.color(ColorCustomization.lightGreen)
//            drawTriangle(Color: Theme.color(ColorCustomization.lightGreen))
//            typeOfMessageImage.image = UIImage(named: "whatsapp")
//            dateLabel.text = historyObj.messageTime
//        } else {
//            messageView.backgroundColor = Theme.color(ColorCustomization.lightBlue)
//            drawTriangle(Color: Theme.color(ColorCustomization.lightBlue))
//            typeOfMessageImage.image = UIImage(named: "textMessage")
//            dateLabel.text = historyObj.messageTime
//
//        }
//    }
    
}


enum TypeOfMessage: String {
    case whatsapp
    case TextMessage
}

class RoundedView: UIView {
    override func layoutSubviews() {
            super.layoutSubviews()

        self.roundCorners([.topLeft, .bottomLeft, .topRight], radius: 6)
        }

}
