//
//  CustomNavigationView.swift
//  KPlus
//
//  Created by Varun Kumar on 07/10/19.
//  Copyright © 2019 ToTheNew. All rights reserved.
//

import UIKit

protocol CustomNavigationViewProtocol: class {
    func rightBtnTapped()
    func backbtnTapped()
}
class CustomNavigationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!

        
    var isSearchBtnPresent = true
    weak var delegate: CustomNavigationViewProtocol?
    
    var hideBackground: Bool = false{
        didSet{
//            backgroundImageView.isHidden = hideBackground
        }
    }
    
    // MARK: UIView Life Cycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    // Function for initial view setup
    private func commonInit() {
        self.clipsToBounds = false           // show clipped image
        Bundle.main.loadNibNamed("CustomNavigationView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //updateNavigationBackgroundImage()    // update navigation background image y position
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 00, bottom: 0, right: -20)
        rightButton.setTitleColor(Color.greenColor, for: .normal)
        rightButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        rightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        rightButton.isHidden = true
        backButton.setTitleColor(Theme.color(ColorCustomization.textColor), for: .normal)
        rightButton.setTitleColor(Theme.color(ColorCustomization.appThemeColor), for: .normal)
        titleLbl.textColor = Theme.color(ColorCustomization.textColor)
        let topShadow = EdgeShadowLayer(forView: containerView, edge: .Top, shadowRadius: 10.0, toColor: Theme.color(ColorCustomization.whiteColor), fromColor: Theme.color(ColorCustomization.shadowColor))
        containerView.layer.addSublayer(topShadow)
    }
    
    // this method update top constraints of background image in navigation bar
//    private func updateNavigationBackgroundImage (){
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        bgImageTopConstraint.constant = -statusBarHeight
//
//        if statusBarHeight > 20{
//            // notch devices
//            logoImageBottomConstraint.constant = 16
//        }else{
//            logoImageBottomConstraint.constant = 8
//        }
//        updateConstraintsIfNeeded()
//    }
    
    // MARK: - Actions
    
    @IBAction func didTapCloseonBtn(_ sender: Any) {
        delegate?.rightBtnTapped()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        delegate?.backbtnTapped()
    }
    
    //MARK : - Send events
    func sendHomePageNotificationToMoengage () {
        let dicAttribute = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.composePage(), attributes: dicAttribute)
    }
    
}
