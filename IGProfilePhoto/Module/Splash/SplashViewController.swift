//
//  SplashViewController.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.    2.0 framework 3.0 framework alt meams
//  coins market 1 tron ADA/cardeno
// BTT no gurente 10times incresas this month sell and buy 

import UIKit
import GoogleMobileAds

class SplashViewController: UIViewController {
    @IBOutlet weak var customView: CustomView!
    @IBOutlet weak var drtMsgLbl: UILabel!
    
    /// The view that holds the native ad.
    @IBOutlet weak var nativeAdPlaceholder: UIView!

    /// Indicates whether videos should start muted.
    @IBOutlet weak var startMutedSwitch: UISwitch!

    /// The refresh ad button.
    @IBOutlet weak var refreshAdButton: UIButton!

    /// Displays the current status of video assets.
    @IBOutlet weak var videoStatusLabel: UILabel!

    /// The SDK version label.
    @IBOutlet weak var versionLabel: UILabel!

    /// The height constraint applied to the ad view, where necessary.
    var heightConstraint: NSLayoutConstraint?

    /// The ad loader. You must keep a strong reference to the GADAdLoader during the ad loading
    /// process.
    var adLoader: GADAdLoader!

    /// The native ad view that is being presented.
    var nativeAdView: GADNativeAdView! //GADUnifiedNativeAdView!

    /// The ad unit ID.
    let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Theme.color(ColorCustomization.appThemeColor)
        drtMsgLbl.textColor = Theme.color(ColorCustomization.appThemeColor)
//        perform(#selector(forceUpdateAppCheck), with: self, afterDelay: 0.9)
         perform(#selector(navigateToNextScreen), with: self, afterDelay: 0.9)
        NotificationHandler.shared.addMorningLocalNotification()
//        NotificationHandler.shared.addEveningLocalNotification()

        // Do any additional setup after loading the view.
//        addNativeAddView()
       
    }
    
    @objc func navigateToNextScreen() {
        if AppUtils.getOnboardingLaunch() {
            if let viewController = ContainerViewController.instantiate(fromAppStoryboard: .DirectMessage){
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }else{
            if let viewController = OnboardingController.instantiate(fromAppStoryboard: .Splash){
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
    }
    
    func addNativeAddView() {
        versionLabel.text = GADMobileAds.sharedInstance().sdkVersion
        guard
          let nibObjects = Bundle.main.loadNibNamed("UnifiedNativeAdView", owner: nil, options: nil),
          let adView = nibObjects.first as? GADNativeAdView
        else {
            assert(false, "Could not load nib file for adView")
            return
        }
        setAdView(adView)
        refreshAd(nil)
    }
    
    func setAdView(_ view: GADNativeAdView) {
      // Remove the previous ad view.
      nativeAdView = view
      nativeAdPlaceholder.addSubview(nativeAdView)
      nativeAdView.translatesAutoresizingMaskIntoConstraints = false

      // Layout constraints for positioning the native ad view to stretch the entire width and height
      // of the nativeAdPlaceholder.
      let viewDictionary = ["_nativeAdView": nativeAdView!]
      self.view.addConstraints(
        NSLayoutConstraint.constraints(
          withVisualFormat: "H:|[_nativeAdView]|",
          options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
      )
      self.view.addConstraints(
        NSLayoutConstraint.constraints(
          withVisualFormat: "V:|[_nativeAdView]|",
          options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary)
      )
    }
    
    // MARK: - Actions

    /// Refreshes the native ad.
    @IBAction func refreshAd(_ sender: AnyObject!) {
        refreshAdButton.isEnabled = false
        videoStatusLabel.text = ""
        let multipleAdsOptions = GADMultipleAdsAdLoaderOptions()
        multipleAdsOptions.numberOfAds = 5
        
        let imageOptions = GADNativeAdImageAdLoaderOptions()
        imageOptions.disableImageLoading = false

        let mediaOptions = GADNativeAdMediaAdLoaderOptions()
        mediaOptions.mediaAspectRatio = .square
        
        adLoader = GADAdLoader(adUnitID: adUnitID, rootViewController: self,
                               adTypes: [GADAdLoaderAdType.native,
                                         GADAdLoaderAdType.customNative],
                               options: [imageOptions, mediaOptions])
//        adLoader = GADAdLoader(
//            adUnitID: adUnitID, rootViewController: self,
//            adTypes: [.unifiedNative], options: nil)
        
        adLoader.delegate = self
        adLoader.load(GADRequest())
    }
    
    /// Returns a `UIImage` representing the number of stars from the given star rating; returns `nil`
    /// if the star rating is less than 3.5 stars.
    func imageOfStars(from starRating: NSDecimalNumber?) -> UIImage? {
      guard let rating = starRating?.doubleValue else {
        return nil
      }
      if rating >= 5 {
        return UIImage(named: "stars_5")
      } else if rating >= 4.5 {
        return UIImage(named: "stars_4_5")
      } else if rating >= 4 {
        return UIImage(named: "stars_4")
      } else if rating >= 3.5 {
        return UIImage(named: "stars_3_5")
      } else {
        return nil
      }
    }


}

extension SplashViewController: GADNativeAdLoaderDelegate {


    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        refreshAdButton.isEnabled = true

        // Set ourselves as the native ad delegate to be notified of native ad events.
        nativeAd.delegate = self

        // Deactivate the height constraint that was set when the previous video ad loaded.
        heightConstraint?.isActive = false

        // Populate the native ad view with the native ad assets.
        // The headline and mediaContent are guaranteed to be present in every native ad.
        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent

        // Some native ads will include a video asset, while others do not. Apps can use the
        // GADVideoController's hasVideoContent property to determine if one is present, and adjust their
        // UI accordingly.
        let mediaContent = nativeAd.mediaContent
        if mediaContent.hasVideoContent {
          // By acting as the delegate to the GADVideoController, this ViewController receives messages
          // about events in the video lifecycle.
          mediaContent.videoController.delegate = self
          videoStatusLabel.text = "Ad contains a video asset."
        } else {
          videoStatusLabel.text = "Ad does not contain a video."
        }

        // This app uses a fixed width for the GADMediaView and changes its height to match the aspect
        // ratio of the media it displays.
        if let mediaView = nativeAdView.mediaView, nativeAd.mediaContent.aspectRatio > 0 {
          heightConstraint = NSLayoutConstraint(
            item: mediaView,
            attribute: .height,
            relatedBy: .equal,
            toItem: mediaView,
            attribute: .width,
            multiplier: CGFloat(1 / nativeAd.mediaContent.aspectRatio),
            constant: 0)
          heightConstraint?.isActive = true
        }

        // These assets are not guaranteed to be present. Check that they are before
        // showing or hiding them.
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        nativeAdView.bodyView?.isHidden = nativeAd.body == nil

        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil

        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.iconView?.isHidden = nativeAd.icon == nil

        (nativeAdView.starRatingView as? UIImageView)?.image = imageOfStars(from: nativeAd.starRating)
        nativeAdView.starRatingView?.isHidden = nativeAd.starRating == nil

        (nativeAdView.storeView as? UILabel)?.text = nativeAd.store
        nativeAdView.storeView?.isHidden = nativeAd.store == nil

        (nativeAdView.priceView as? UILabel)?.text = nativeAd.price
        nativeAdView.priceView?.isHidden = nativeAd.price == nil

        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
        nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil

        // In order for the SDK to process touch events properly, user interaction should be disabled.
        nativeAdView.callToActionView?.isUserInteractionEnabled = false

        // Associate the native ad view with the native ad object. This is
        // required to make the ad clickable.
        // Note: this should always be done after populating the ad views.
        nativeAdView.nativeAd = nativeAd

      }
    
    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        print("adLoaderDidFinishLoading %@", adLoader)
          // The adLoader has finished loading ads, and a new request can be sent.
      }
    
    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print("%@ failed with error: %@", adLoader, error)
        
    }

//     func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
//         // The adLoader has finished loading ads, and a new request can be sent.
//     }
}

extension SplashViewController: GADVideoControllerDelegate {
    func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
        print("videoControllerDidEndVideoPlayback")
    }
    
    func videoControllerDidPlayVideo(_ videoController: GADVideoController) {
        print("videoControllerDidPlayVideo")
        print("\(#function) called")
    }
    
    func videoControllerDidMuteVideo(_ videoController: GADVideoController) {
        print("videoControllerDidMuteVideo")
    }
    
    func videoControllerDidPauseVideo(_ videoController: GADVideoController) {
        print("videoControllerDidPauseVideo")
    }
    
    func videoControllerDidUnmuteVideo(_ videoController: GADVideoController) {
        print("videoControllerDidUnmuteVideo")
    }
    
}
extension SplashViewController: GADNativeAdDelegate {
    func nativeAdDidRecordImpression(_ nativeAd: GADNativeAd) {
      // The native ad was shown.
        print("\(#function) called")
    }

    func nativeAdDidRecordClick(_ nativeAd: GADNativeAd) {
      // The native ad was clicked on.
        print("\(#function) called")
    }

    func nativeAdWillPresentScreen(_ nativeAd: GADNativeAd) {
      // The native ad will present a full screen view.
        print("\(#function) called")
    }

    func nativeAdWillDismissScreen(_ nativeAd: GADNativeAd) {
      // The native ad will dismiss a full screen view.
    }

    func nativeAdDidDismissScreen(_ nativeAd: GADNativeAd) {
      // The native ad did dismiss a full screen view.
        print("\(#function) called")
    }

    func nativeAdWillLeaveApplication(_ nativeAd: GADNativeAd) {
      // The native ad will cause the application to become inactive and
      // open a new application.
        print("\(#function) called")
    }
    
}

extension SplashViewController : GADCustomNativeAdLoaderDelegate {
    func customNativeAdFormatIDs(for adLoader: GADAdLoader) -> [String] {
        print("GADCustomNativeAdLoaderDelegate \(#function) called")
        return [""]

    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive customNativeAd: GADCustomNativeAd) {
        print("GADCustomNativeAdLoaderDelegate \(#function) called")

    }
}

extension SplashViewController {
    @objc func forceUpdateAppCheck() {
        if self.isUpdateRequired() {
            let alert = UIAlertController(title: "Force Update", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "UPDATE", style: .default, handler: { action in
                self.openAppURL()
            }))
//            alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
//
//            }))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            navigateToNextScreen()
            print("Already Updated")
        }
    }
    
    func openAppURL() {
        print("Need To update")
        let appStoreLink : String = APPSTORE_APP_URL_STRING
        if let url = URL(string: appStoreLink), UIApplication.shared.canOpenURL(url) {
            // Attempt to open the URL.
            UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
                if success {
                    print("Launching \(url) was successful")
                }})
        }
        self.forceUpdateAppCheck()
    }
    
    func isUpdateRequired() -> Bool {
        
        RCValues.sharedInstance.fetchCloudValues()
        let currentAppVersion = RCValues.sharedInstance.string(forKey: .appVersion)
        print("currentAppVersion \(currentAppVersion)")
       
        
        let infoDict = Bundle.main.infoDictionary
        let myVersionStr = infoDict?["CFBundleShortVersionString"] as? String
        var myVersionArray = myVersionStr?.components(separatedBy: ".")
//        let minRequiredVersionStr = KPConfigDataManager.sharedInstance.configData?.ios?.appVersion

        let minRequiredVersionStr = currentAppVersion
        //        let minRequiredVersionStr = "2.0.12.1.1" //for testing purpose
        var minRequiredVersionArray = (minRequiredVersionStr ?? "0").components(separatedBy: ".")
        
        let max_tuples = Int(max(myVersionArray?.count ?? 0, minRequiredVersionArray.count))
        
        if myVersionArray?.count ?? 0 > minRequiredVersionArray.count {
            let totalDiffernce = myVersionArray?.count ?? 0 - minRequiredVersionArray.count
            for _ in 0..<totalDiffernce {
                minRequiredVersionArray.append("0")
            }
        } else if myVersionArray?.count ?? 0 < minRequiredVersionArray.count {
            let totalDiffernce = minRequiredVersionArray.count  - (myVersionArray?.count ?? 0)
            for _ in 0..<totalDiffernce {
                myVersionArray?.append("0")
            }
        }
        
        for i in 0..<max_tuples {
            if Int(minRequiredVersionArray[i]) ?? 0 > Int(myVersionArray?[i] ?? "") ?? 0 {
                return true
            } else if Int(minRequiredVersionArray[i]) ?? 0 < Int(myVersionArray?[i] ?? "") ?? 0 {
                return false
            }
        }
        return false
    }
}

