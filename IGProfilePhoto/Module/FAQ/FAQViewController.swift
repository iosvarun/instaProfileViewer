//
//  FAQViewController.swift
//  DirectMessage
//
//  Created by MOHIT PAREEK on 01/03/21.
//

import UIKit
import FAQView

class FAQViewController: UIViewController, ViewControllerFromStoryboard {
    static var storyboardName = "DirectMessage"

    @IBOutlet weak var navBar: CustomNavigationView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpInitialUI()
    }
    
    fileprivate func setUpInitialUI(){
        navBar.delegate = self
        navBar.backButton.isHidden = false
        navBar.backButton.setTitle("Settings", for: .normal)
        let items = [FAQItem(question: "What is this app for?", answer: "This app is used to send whatsapp messages or text messages without saving the contact"),
        FAQItem(question: "What details do I have to fill for sending a message?", answer: "All you need to do is just enter the number with required country code and type the message to send the message"),
        FAQItem(question: "What is Custom Message", answer: "Users can save a custom message for their future purpose. All they have to do is add a title and a text and then save the message.")]

        let faqView = FAQView(frame: view.frame, title: "Top Queries", items: items)
        contentView.addSubview(faqView)
        faqView.backgroundColor = Theme.color(ColorCustomization.whiteColor)
        faqView.cellBackgroundColor = Theme.color(ColorCustomization.cellBgColor)
        faqView.separatorColor = Theme.color(ColorCustomization.clearColor)
        faqView.questionTextFont = UIFont(name: "HelveticaNeue-Medium", size: 16)
        faqView.answerTextFont = UIFont(name: "HelveticaNeue-Regular", size: 14)
    }

}

extension FAQViewController: CustomNavigationViewProtocol {
    func rightBtnTapped() {
        
    }
    
    func backbtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }    
}

extension FAQViewController {
    func analyticsEventFAQPage() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.faqPage(), attributes: attributes)
    }
}
