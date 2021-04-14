//
//  PrivacyPolicyViewController.swift
//  DirectMessage
//
//  Created by Varun Kumar on 02/03/21.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController, ViewControllerFromStoryboard, WKUIDelegate {
    static var storyboardName = "DirectMessage"

    @IBOutlet weak var navBar: CustomNavigationView!
    @IBOutlet weak var termsConditionTxtView: UITextView!
    @IBOutlet weak var privacyPolicyTxtView: UITextView!
    
    @IBOutlet weak var webView: WKWebView!
    var isPrivacyPolicy = false
    var navBartitle = ""
    var webUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialUI()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setUpInitialUI(){
        navBar.delegate = self
        navBar.backButton.isHidden = false
        navBar.titleLbl.text = navBartitle
        navBar.titleLbl.isHidden = false
        navBar.backButton.setTitle("        ", for: .normal)
        if isPrivacyPolicy {
            let myURL = URL(string: webUrl)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            self.analyticsEventPrivacyPolicyPage()
        }else {
            let myURL = URL(string: webUrl)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            self.analyticsEventTermsAndConditionsPage()
        }
        webView.uiDelegate = self
        
        
    }

}

extension PrivacyPolicyViewController: CustomNavigationViewProtocol {
    
    func rightBtnTapped() {
        
    }
    
    func backbtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PrivacyPolicyViewController {
    func analyticsEventPrivacyPolicyPage() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.privacyPolicyPage(), attributes: attributes)
    }
    
    func analyticsEventTermsAndConditionsPage() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.termsAndConditionsPage(), attributes: attributes)
    }
}
