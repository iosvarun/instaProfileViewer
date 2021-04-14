//
//  SettingsViewController.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import UIKit
import SwipeCellKit
import StoreKit
import MessageUI

class SettingsViewController: UIViewController, ViewControllerFromStoryboard, MFMailComposeViewControllerDelegate {
    static var storyboardName = "DirectMessage"
    // SettingModel.init(title: "Remove Ad"),
    var settingDataSource = [SettingModel.init(title: "Contact Us"), SettingModel.init(title: "Rate App"), SettingModel.init(title: "Share This App"), SettingModel.init(title: "FAQ"), SettingModel.init(title: "Privacy Policy"), SettingModel.init(title: "Terms And Condition")]


    @IBOutlet weak var appVersionTextLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var sepratorLineLbl: UILabel!

    var viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")

        // Do any additional setup after loading the view.
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.rowHeight = UITableView.automaticDimension
        settingsTableView.estimatedRowHeight = 60
        let nib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        settingsTableView.register(nib, forCellReuseIdentifier: "settingsCell")
        settingsTableView.alwaysBounceVertical = false
        appVersionTextLabel.textColor = Theme.color(ColorCustomization.lightBgColor)
        appVersionTextLabel.text = AppUtility.getAppVersion()
        sepratorLineLbl.backgroundColor = Theme.color(ColorCustomization.lightBgColor)

        self.analyticsEventSettingsPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
   
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["utlityapps@gmail.com"])
            mail.setSubject("Email From Direct Message")
            mail.setMessageBody("<p> The App version is \(AppUtility.getAppVersion())</p>", isHTML: true)
            present(mail, animated: true, completion: nil)
        } else {
            print("sendEmail ipad")
            // show failure alert
            let alert = UIAlertController(title: "Alert", message: "No mail account setup on device", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")

                  case .cancel:
                        print("cancel")

                  case .destructive:
                        print("destructive")
            }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)

    }

}


extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsCell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsTableViewCell
        let item = settingDataSource[indexPath.row]
        settingsCell.configureCell(settingModel: item)
        return settingsCell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //
        let item = settingDataSource[indexPath.row]
        
        guard let settingKey = SettingsViewModel.SettingKey(rawValue: item.title) else {
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
            return
        }
        
        switch settingKey {
//        case .RemoveAd:
//
//            print("RemoveAd")

        case .ContactUs:

            sendEmail()
            self.analyticEventContactUs()
            break
        case .RateApp:
            self.rateApp()
            self.analyticEventRateApp()
            break
        case .ShareApp:
            shareApp()
            self.analyticEventShareApp()
            break
        case .FAQ:
            let faqViewController = FAQViewController.viewController()
            navigationController?.pushViewController(faqViewController, animated: true)
            self.analyticEventFAQ()
            break
        case .PrivacyPolicy:
            navigateToPrivacyPolicyVC(value: true, navbarTitle: "Privacy Policy", url: "https://mohitpareek25.github.io/Privacy-Policy/")
            self.analyticEventPrivacyPolicy()
            break
        case .TermsAndCondition:
            navigateToPrivacyPolicyVC(value: false, navbarTitle: "Terms And Condition", url: "https://mohitpareek25.github.io/Terms-And-Conditions/")
            self.analyticEventTermsAndConditions()
            break
            
        }
    }
    
    func rateApp() {
        RCValues.sharedInstance.fetchCloudValues()
        if RCValues.sharedInstance.bool(forKey: .showCustomRating) {
            SwiftRate.appID = APPSTORE_APP_ID
            SwiftRate.shared.showRatingAlert(host: self)
        }else{
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
                print("SKStoreReviewController")
            } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "id1557291502") {
                UIApplication.shared.openURL(url)
                print("UIApplication")
            }
        }
    }
    
    func shareApp(){
//        let controller : UIActivityViewController  = UIActivityViewController.init(activityItems: ["Hey I am using Call Recorder.  to record my incoming and outgoing calls and its cool.Get the app here \(AppConfigs.getConfigValue(for: "app_url_itunes_url"))"], applicationActivities: nil)
        let controller : UIActivityViewController  = UIActivityViewController.init(activityItems: ["Hey I am using DirectMessage to send messages without saving number. Get the app here https://apps.apple.com/us/app/direct-message-for-whatsapp/id1557291502"], applicationActivities: nil)
        if IS_IPAD {
            if let popoverController = controller.popoverPresentationController {
                popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)

                popoverController.sourceView = self.view
                popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            }

            self.present(controller, animated: true, completion: nil)
        }else{
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func navigateToPrivacyPolicyVC(value: Bool, navbarTitle: String, url: String) {
        let privacyPolicyVC = PrivacyPolicyViewController.viewController()
        privacyPolicyVC.isPrivacyPolicy = value
        privacyPolicyVC.navBartitle = navbarTitle
        privacyPolicyVC.webUrl = url
        navigationController?.pushViewController(privacyPolicyVC, animated: true)
    }

    
}

extension SettingsViewController {
    
    func analyticsEventSettingsPage() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.settingsPage(), attributes: attributes)
    }
    
    func analyticEventContactUs() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.contactUs(), attributes: attributes)
    }
    
    func analyticEventRateApp() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.rateApp(), attributes: attributes)
    }
    
    func analyticEventShareApp() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.shareApp(), attributes: attributes)
    }
    
    func analyticEventFAQ() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.faq(), attributes: attributes)
    }
    
    func analyticEventPrivacyPolicy() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.privacyPolicy(), attributes: attributes)
    }
    
    func analyticEventTermsAndConditions() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.termsAndCondition(), attributes: attributes)
    }
    
    func analyticEventRemoveAd() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.removeAd(), attributes: attributes)
    }
}

extension SettingsViewController: ViewModelDelegate {
    func toggleOverlay(shouldShow: Bool) {
//        overlayView.isHidden = !shouldShow
    }
    
    func shouldUpdateUI() {
        settingsTableView.reloadData()
    }
    
    func willStartLongProcess() {
//        overlayView.isHidden = false
    }
    
    func didFinishLongProcess() {
//        overlayView.isHidden = true
    }
    
    func showIAPRelatedError(_ error: Error) {
        let message = error.localizedDescription
        
        // In a real app you might want to check what exactly the
        // error is and display a more user-friendly message.
        // For example:
        /*
        switch error {
        case .noProductIDsFound: message = NSLocalizedString("Unable to initiate in-app purchases.", comment: "")
        case .noProductsFound: message = NSLocalizedString("Nothing was found to buy.", comment: "")
        // Add more cases...
        default: message = ""
        }
        */
        
        showSingleAlert(withMessage: message)
    }
    
    func didFinishRestoringPurchasesWithZeroProducts() {
        showSingleAlert(withMessage: "There are no purchased items to restore.")
    }
    
    
    func didFinishRestoringPurchasedProducts() {
        showSingleAlert(withMessage: "All previous In-App Purchases have been restored!")
    }
    
    func showSingleAlert(withMessage message: String) {
        let alertController = UIAlertController(title: "FakeGame", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
