//
//  InAppViewController.swift
//  DirectMessage
//
//  Created by Varun Kumar on 07/04/21.
//

import UIKit

class InAppViewController: UIViewController, ViewControllerFromStoryboard {
    static var storyboardName = "Splash"
    
    @IBOutlet weak var inAppTableView: UITableView!
    @IBOutlet weak var drctMsgLbl: UILabel!
    @IBOutlet weak var proLbl: UILabel!
    @IBOutlet weak var subscriptionBtn: UIButton!

    var inAppDataSource = [InAppCellModel.init(title: "Remove ads"),InAppCellModel.init(title: "Remove the banner ad"),InAppCellModel.init(title: "Unlock the auto paste functionality"),InAppCellModel.init(title: "Unlock unlimited custom message"), InAppCellModel.init(title: "Unlock share current location.")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    fileprivate func initialSetup () {
        inAppTableView.dataSource = self
        inAppTableView.delegate = self
        inAppTableView.rowHeight = UITableView.automaticDimension
        inAppTableView.estimatedRowHeight = 30
        let nib = UINib(nibName: "InAppTableViewCell", bundle: nil)
        inAppTableView.register(nib, forCellReuseIdentifier: "InAppTableViewCell")
        inAppTableView.alwaysBounceVertical = false
        
        proLbl.backgroundColor = Theme.color(ColorCustomization.inAppPro)
        proLbl.textColor = Theme.color(ColorCustomization.whiteColor)
//        proLbl.layer.cornerRadius = proLbl.frame.size.width / 2
        proLbl.cornerRadius(8)
        subscriptionBtn.cornerRadius(6)
        subscriptionBtn.setTitle("subscriptionBtn", for: .normal)
        subscriptionBtn.backgroundColor = Theme.color(ColorCustomization.appThemeColor)
        subscriptionBtn.titleLabel?.textColor = Theme.color(ColorCustomization.whiteColor)
        
        
        IAPService.instance.iapDelegate = self
        IAPService.instance.loadProducts()
        NotificationCenter.default.addObserver(self, selector: #selector(showRestoredAlert), name: NSNotification.Name(IAPServiceRestoreNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(subscriptionStatusChanged(_:)), name: NSNotification.Name(IAPSubscriptionInformationWasChangedNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseStatus(_:)), name: NSNotification.Name(IAPServicePurchaseNotification), object: nil)

        
    }
    
    //MARK:- IBOutlets
    @IBAction func closeBtnTapped(_sender: Any) {
        RCValues.sharedInstance.fetchCloudValues()
        if RCValues.sharedInstance.bool(forKey: .closeInAppScreen) {
            self.dismiss(animated: true, completion: nil)
        }else{
        }
    }
    
    //MARK:- IBOutlets
    @IBAction func subscriptionBtnTapped(_sender: Any) {
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .monthlySub)

    }
    
    //MARK:- IBOutlets
    @IBAction func termsAndConditionBtnTapped(_sender: Any) {
        
    }
    
    //MARK:- IBOutlets
    @IBAction func restoreBtnTapped(_sender: Any) {
        let alert = UIAlertController(title: "Restore Purchases?", message: "Do you want to restore any in-app purchases you've previously purchased?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Restore", style: .default) { (action) in
            IAPService.instance.restorePurchases()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func showRestoredAlert() {
        let alert = UIAlertController(title: "Success!", message: "Your purchases were successfully restored.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func subscriptionStatusChanged(_ notification: Notification) {
        guard let status = notification.object as? Bool else { return }
        if status == true {
            self.view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            print("SUBSCRIPTION VALID")
        } else {
            self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            print("SUBSCRIPTION EXPIRED")
        }
    }
    
    @objc func purchaseStatus(_ notification: Notification) {
        print("notification userInfo \(String(describing: notification.userInfo))")
        print("notification object \(String(describing: notification.object))")

//        guard let status = notification.c as? Bool else { return }
//        if status == true {
//            print("SUBSCRIPTION VALID")
//        } else {
//            print("SUBSCRIPTION EXPIRED")
//        }
    }
    
    

}

extension InAppViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inAppDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inAppCell = tableView.dequeueReusableCell(withIdentifier: "InAppTableViewCell") as! InAppTableViewCell
        let item = inAppDataSource[indexPath.row]
        inAppCell.configureCell(inAppCellModel: item)
        return inAppCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
}

extension InAppViewController: IAPServiceDelegate {
    func iapProductsLoaded() {
        print("IAP PRODUCTS LOADED!")
        view.isUserInteractionEnabled = true
    }
}
