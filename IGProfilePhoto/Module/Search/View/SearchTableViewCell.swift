//
//  SearchTableViewCell.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 10/04/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell, ReuseIdentifier, ViewFromNib {

    static let searchCellIdentifier = "searchCellIdentifier"

    static var resuseIdentifier: String {
        return SearchTableViewCell.searchCellIdentifier
    }
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(userData: User) {
//        self.hotelImageView.image = nil
        userNameLbl.text = userData.username
        fullNameLbl.text = userData.full_name

        
//        if let imageURL = viewModel.imageURL {
//            SRImageDownloader.shared.downloadImage(from: imageURL) { (image, error) in
//                if let image = image {
//                    DispatchQueue.main.async {
//                        self.hotelImageView.image = image.imageResized(to: self.hotelImageView.bounds.size)
//                    }
//                }else {
//                    print(error?.localizedDescription as Any)
//                }
//            }
//        }
    }
    
}
