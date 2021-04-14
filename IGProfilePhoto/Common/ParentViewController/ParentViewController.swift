//
//  KPParentViewController.swift
//  KPlus
//
//  Created by Varun Kumar on 03/01/20.
//  Copyright © 2020 Varun Kumar. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if support localization
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKPLanguageChangedNotification), name: NSNotification.Name(rawValue: KPNotificationName.languageChangedNotification.rawValue), object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    func askUserToLogin (strSource: String, completion:((Bool) -> Void)? = nil) {
    }
    
    @objc func handleKPLanguageChangedNotification () {
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
    }
    
}

extension ParentViewController: CustomNavigationViewProtocol {
    @objc func backbtnTapped() {
        //asas
    }
    
    func profileBtnTapped() {
//        let storyboard = AppStoryboard.KPUserProfileStoryboard
//        if let profileViewController = KPUserProfileViewController.instantiate(fromAppStoryboard: storyboard){
//            let navController = KPProfileNavigationController.init(rootViewController: profileViewController)
//            navController.modalPresentationStyle = .fullScreen
//            self.tabBarController?.present(navController, animated: true, completion: nil)
//        }
    }
    
    func notificationBtnTapped() {
//        if let notificationViewController = KPNotificationViewController.instantiate(fromAppStoryboard: AppStoryboard.KPNotificationStoryboard){
//            self.navigationController?.pushViewController(notificationViewController, animated: true)
//        }
    }
    
    func rightBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}
