//
//  SearchViewController.swift
//  IGProfilePhoto
//
//  Created by Varun Kumar on 10/04/21.
//

import UIKit
import GoogleMobileAds

class SearchViewController: UIViewController, ViewControllerFromStoryboard {
    static let storyboardName = "DirectMessage"

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearSearchImageView: UIImageView!
    
    @IBOutlet weak var searchTableView: UITableView!

    @IBOutlet weak var bannerContainerView: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    var viewModel: SearchViewModel!

    var adLoader: GADAdLoader!
    
    /// initiate a refreshControl variable
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(SearchViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.backgroundColor =  UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        refreshControl.tintColor = UIColor(red: 0/255.0, green: 49/255.0, blue: 67/255.0, alpha: 1.0)
        
        return refreshControl
    }()
    /// The InterstitialAd video ad.
    var interstitial: GADInterstitialAd?
    
    /// The rewarded video ad.
    var rewardedAd: GADRewardedAd?
    
    /// The RewardedInterstitialAd video ad.
    var rewardedInterstitialAd: GADRewardedInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        configureGestureRecognizer()
        configurePlaceHolder()
        loadAllAdmob()
        userChannelAPI()
        // Do any additional setup after loading the view.
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let customMsgDataSource =  CustomMessage.getAllMessage() {
//            if customMsgDataSource.count == 0 {
//                DispatchQueue.main.async {
//                    self.customMsgLbl.text = "Select from custom message - " + " msg"
//                }
//            }else{
//                DispatchQueue.main.async {
//                    self.customMsgLbl.text = "Select from custom message - " + "\(String(describing: customMsgDataSource.count))" + " msg"
//                }
//            }
//        }
        
        loadAdMobBanner()

        RCValues.sharedInstance.fetchCloudValues()
        if RCValues.sharedInstance.bool(forKey: .showBannerAd) {
        }else{
        }
        
//        viewModel.topSearchuser(searchUserName: "varun") { (user, error) in
//            if let error = error{
//                print("topSearchuser error\(error.localizedDescription)")
//                //AlertUtility.showAlert(self, title: error.title, message: error.description)
//            }else{
//                print("user?.user?.full_name \(String(describing: user?.first?.user?.full_name))")
//            }
//        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
        
    fileprivate func initialSetup () {
        searchTextField.textColor = .white
        clearSearchImageView.isHidden = true
//        searchTextField.becomeFirstResponder()
        searchBarView.clipsToBounds = true
        searchBarView.layer.cornerRadius = 6.0
        
//        self.searchTableView.addSubview(self.refreshControl)
        self.searchTableView.rowHeight = UITableView.automaticDimension
        self.searchTableView.estimatedRowHeight = 80
        searchTableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.resuseIdentifier)
        
//        loadTopSearchUser(searchText: "varun")
        
    }
    
    func loadTopSearchUser(searchText: String) {
        viewModel.topSearchuser(searchUserName: searchText) { (user, error) in
            if let error = error{
                print("topSearchuser error")
                //AlertUtility.showAlert(self, title: error.title, message: error.description)
            }else{
                print("user?.user?.full_name \(String(describing: user?.first?.user?.full_name))")
            }
        }
    }
    
    /// pull to refresh action
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
    }
}

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.resuseIdentifier) as? SearchTableViewCell ?? SearchTableViewCell.firstView as! SearchTableViewCell
//        let item = viewModel.itemViewModel(at: indexPath)
//        cell.configureCell(viewModel: item)
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController {
    /// Gesture recongnizer setup
    private func configureGestureRecognizer(){
        clearSearchImageView.isUserInteractionEnabled = true
        let clearButtonTap = UITapGestureRecognizer(target: self, action: #selector(self.clearTextField(_:)))
        clearSearchImageView.addGestureRecognizer(clearButtonTap)

    }
    
    /// Clear the TextField when cross button tapped
    /// - Parameter sender: UITapGestureRecognizer
    @objc func clearTextField(_ sender: UITapGestureRecognizer? = nil) {
        searchTextField.text = ""
        clearSearchImageView.isHidden = true
    }
    
    /// Place holder configuration
    private func configurePlaceHolder() {
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Username" ,attributes: [NSAttributedString.Key.foregroundColor: Theme.color(ColorCustomization.appThemeColor)])
    }
    
    //MARK: - IBActions -
    
    /// If textfield charcters are more then one then the clear textfield cross button is shown else remains hidden
    /// - Parameter sender: Any
    @IBAction func searchEditingChanged(_ sender: Any) {
        if searchTextField.text!.removeWhiteSpace().count < 1 {
            clearSearchImageView.isHidden = true
        } else {
            clearSearchImageView.isHidden = false
        }
    }
}


extension SearchViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    
    /// when user enter any text in textfield
    /// - Parameter textField: selected textfield, removes white spaces , appends the searched item into the recently searched item.
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = searchTextField.text!.removeWhiteSpace()
        guard !text.isEmpty else {
//            hotelListViewController.clearFilter()
            return
        }
        
//        hotelListViewController.filterHotels(text)
    }
    
    /// when return button of the keyboard is tapped hides the keyboard , removes white spaces , appends the searched item into the recently searched item.
    /// - Parameter textField: selected textfield
    /// - Returns: boolean
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if searchTextField.text!.removeWhiteSpace().count > 0 {
            searchTextField.resignFirstResponder()
            searchTextField.endEditing(true)
        } else {
            searchTextField.resignFirstResponder()
            searchTextField.endEditing(true)
        }
        return true
    }
}

extension SearchViewController: AlertPresentable {
    
    var alertComponents: AlertComponents {
        let okAction = AlertActionComponent(title: "Ok", handler: {_ in })
         let alertComponents = AlertComponents(title: "Invalid Phone Number", message: "Please Enter the valid phone number.", actions: [okAction], completion: {
     })
         return alertComponents
     }

}

extension SearchViewController {
    
    func showActionSheet() {
        RCValues.sharedInstance.fetchCloudValues()
        if RCValues.sharedInstance.bool(forKey: .showGoogleAds) {
            if var admobCount = AppUtils.getAdMobAdDisplayCount() {
                if admobCount == 3 {
                    print("show Google Ad")
                    self.loadRemoteConfigValueForAdMob()
                    AppUtils.setAdMobAdDisplayCount(0)
                }else{
                    print("increase the count to show the Google Ad")
                    admobCount += 1
                    AppUtils.setAdMobAdDisplayCount(admobCount)
                }
            }else{
                AppUtils.setAdMobAdDisplayCount(1)
            }
        }else{
        }
    }
    
    func loadRemoteConfigValueForAdMob () {
        if RCValues.sharedInstance.bool(forKey: .showInterstitialAd) {
            presentInterstitialad()
            print("presentInterstitialad")
        }else if RCValues.sharedInstance.bool(forKey: .showRewardInterstitial){
            presentRewardInterstitialad()
            print("presentRewardInterstitialad")
            
        }else if RCValues.sharedInstance.bool(forKey: .showRewardedAd){
            presentRewardedAd()
            print("presentRewardedAd")
        }
    }
    

    
    func saveMsg(number: String, type: String) {
        //        if let historyMessageArray = MessageHistory.getAllMessage() {
        //            if historyMessageArray.count > 0 {
        //                let messageObj = historyMessageArray.last
        //                let messageId = messageObj!.messageId + 1
        //                MessageHistory.storeHistoryMessage(messageId: messageId, messageType: type, messageTime: AppUtility.getStringFromDate(date: Date(),formatter: "MMM dd, yyyy"), phoneNumber: number, messageTxt: typeMsgTextView.text, timeStamp: String(Date().timeIntervalSince1970))
        //            }else{
        //                MessageHistory.storeHistoryMessage(messageId: 1, messageType: type, messageTime: AppUtility.getStringFromDate(date: Date(),formatter: "MMM dd, yyyy"), phoneNumber: number, messageTxt: typeMsgTextView.text, timeStamp: String(Date().timeIntervalSince1970))
        //            }
        //        }
    }
    
    func analyticEventSendViaWhatsapp(number: String, textMessage: String) {
        let attributes = NSMutableDictionary()
        attributes.setValue(number, forKey: AnalyticsEventAttributes.phoneNumber())
        attributes.setValue(textMessage, forKey: AnalyticsEventAttributes.message())
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.sendViaWhatsapp(), attributes: attributes)
    }
    
    func analyticEventSendViaiPhoneMessageApp(number: String, textMessage: String) {
        let attributes = NSMutableDictionary()
        attributes.setValue(number, forKey: AnalyticsEventAttributes.phoneNumber())
        attributes.setValue(textMessage, forKey: AnalyticsEventAttributes.message())
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.sendViaiPhoneMessageApp(), attributes: attributes)
    }
}

extension SearchViewController: GADFullScreenContentDelegate {
    func againLoadAllAdMob() {
        if let admobCount = AppUtils.getAdMobAdDisplayCount() {
            if admobCount == 3 {
                print("loadAllAdmob")
                loadAllAdmob()
            }else{
                print("loadAllAdmob not yet")
            }
        }
    }
    
    func loadAllAdmob() {
        loadInterstitial()
        loadRewardInterstitial()
        loadRewardedAd()
    }
    
    func loadAdMobBanner() {
        bannerView.adUnitID = "ca-app-pub-7950371036228408/9382493781"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    fileprivate func loadInterstitial() {
      let request = GADRequest()
      GADInterstitialAd.load(
        withAdUnitID: INTERSTITAL_ADMOB_ID, request: request
      ) { (ad, error) in
        if let error = error {
          print("Failed to load interstitial ad with error: \(error.localizedDescription)")
          return
        }
        self.interstitial = ad
        self.interstitial?.fullScreenContentDelegate = self
      }
    }
    
    fileprivate func presentInterstitialad() {
        if let ad = self.interstitial {
            ad.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
    }
    
    fileprivate func loadRewardInterstitial() {
      let request = GADRequest()
        GADRewardedInterstitialAd.load(withAdUnitID: INTERSTITAL_REWARDEDAD_ADMOB_ID, request: request) { (rwInterstitialAd, error) in
            if let error = error {
                print("Failed to load GADRewardedInterstitialAd ad with error: \(error.localizedDescription)")
                return
            }
            self.rewardedInterstitialAd = rwInterstitialAd
            self.rewardedInterstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    @objc fileprivate func presentRewardInterstitialad() {
        if let rewardedInterstitialAd  = rewardedInterstitialAd {
            rewardedInterstitialAd.present(fromRootViewController: self) {
            }
        }else{
            print("Ad wasn't ready")
        }
    }
    
    fileprivate func loadRewardedAd () {
        GADRewardedAd.load(
          withAdUnitID: REWARDEDAD_ADMOB_ID, request: GADRequest()
        ) { (ad, error) in
          if let error = error {
            print("Rewarded ad failed to load with error: \(error.localizedDescription)")
            return
          }
          print("Loading Succeeded")
          self.rewardedAd = ad
          self.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    fileprivate func presentRewardedAd() {
        if let ad = rewardedAd {
          ad.present(fromRootViewController: self) {
            let reward = ad.adReward
            print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
//            self.earnCoins(NSInteger(truncating: reward.amount))
            // TODO: Reward the user.
          }
        } else {
//          let alert = UIAlertController(
//            title: "Rewarded ad isn't available yet.",
//            message: "The rewarded ad cannot be shown at this time",
//            preferredStyle: .alert)
//          let alertAction = UIAlertAction(
//            title: "OK",
//            style: .cancel,
//            handler: { [weak self] action in
////              self?.startNewGame()
//            })
//          alert.addAction(alertAction)
//          self.present(alert, animated: true, completion: nil)
        }
      }
    
    // MARK: - GADFullScreenContentDelegate

    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did present full screen content.")
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error)
    {
      print("Ad failed to present full screen content with error \(error.localizedDescription).")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        
    }
    

    
    func userChannelAPI() {
        let params: QueryParams = [:]
        InstaRecoderService.userChannel(params, userName: "pareek_pe_pareek", headers: [:]) { [weak self] (response) in
            guard let `self` = self else { return }
            
            if let data = response as? Data {
                do {
                    print("CallRecoderService.searchUser")
                }catch {
                    print("recordDetailsCompletionHandler")
                }
            }
        } errorCallback: { (error) in
            print("CallRecoderService error description \(error.localizedDescription)")
        } networkErrorCallback: {
            print("networkErrorCallback")
        }
    }
    
}




