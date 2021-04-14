//
//  ContainerViewController.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import UIKit

enum DirectMessageType: Int  {
    case search
    case favourite
    case history
    case setting
    var title: String {
        switch self  {
        case .search:
            return SEARCH
        case .favourite:
            return FAVOURITE
        case .history:
            return HISTORY
        case .setting:
            return SETTINGS
        }
    }
    
    var selctedIndex: Int {
        switch self  {
        case .search:
            return self.rawValue
        case .favourite:
            return self.rawValue
        case .history:
            return self.rawValue
        case .setting:
            return self.rawValue
        }
    }
}

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var directLbl: UILabel!
    @IBOutlet weak var paginControlHolderView: UIView!

    @IBOutlet weak var mainContainerView: UIView!
    var pagingControl: PagingControl!

    lazy var searchViewController: SearchViewController = {
        let viewController =  SearchViewController.viewController()
        viewController.viewModel = SearchViewModel(apiHandler: SearchAPIHandler(), parseHandler: SearchParseHandler())
        self.addChildViewController(viewController, inView: mainContainerView)
        return viewController

    }()
    
    lazy var favouriteViewController: FavouriteViewController = {
        let viewController = FavouriteViewController.viewController()
        self.addChildViewController(viewController, inView: mainContainerView)
        return viewController
    }()

    lazy var historyViewController: HistoryViewController = {
        let viewController =  HistoryViewController.viewController()
        self.addChildViewController(viewController, inView: mainContainerView)
        return viewController

    }()
    
    lazy var settingsViewController: SettingsViewController = {
        let viewController =  SettingsViewController.viewController()
        self.addChildViewController(viewController, inView: mainContainerView)
        return viewController

    }()
    
    

    
    var authIntentionType: DirectMessageType = .search

    fileprivate var currentTab : DirectMessageType = .search {
        didSet{
            switch self.currentTab {
            case .search:
                remove(asChildViewController: searchViewController)
                self.addChildViewController(searchViewController, inView: mainContainerView)
            case .favourite:
                remove(asChildViewController: favouriteViewController)
                self.addChildViewController(favouriteViewController, inView: mainContainerView)
                
            case .history:
                remove(asChildViewController: historyViewController)
                self.addChildViewController(historyViewController, inView: mainContainerView)
                
            case .setting:
                remove(asChildViewController: settingsViewController)
                self.addChildViewController(settingsViewController, inView: mainContainerView)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        directLbl.textColor = Theme.color(ColorCustomization.appThemeColor)
        settingsViewController = SettingsViewController.viewController()
        favouriteViewController =  FavouriteViewController.viewController()
        historyViewController = HistoryViewController.viewController()
        settingsViewController = SettingsViewController.viewController()
        addPagingControl()
        
        currentTab = authIntentionType
        
        if case .search = currentTab{
            currentTab = .search
        }
        
        pagingControl.selectedIndex = currentTab.selctedIndex
    }
    
    func addPagingControl(){
        pagingControl = PagingControl(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 36))
        pagingControl.delegate = self
        pagingControl.selectedTitleColor = Theme.color(ColorCustomization.appThemeColor)
        pagingControl.titleColor = Theme.color(ColorCustomization.appThemeColor)
        
        pagingControl.titleFont = Theme.Font.regular(FontSize.Huge.rawValue)
        pagingControl.selectedTitleFont = Theme.Font.medium(FontSize.normalSmall.rawValue)

        pagingControl.indicatorViewColor = Theme.color(ColorCustomization.appThemeColor)
        pagingControl.pagingItems = [
            PagingItem(title: DirectMessageType.search.title.uppercased()),
            PagingItem(title: DirectMessageType.favourite.title.uppercased()),
            PagingItem(title: DirectMessageType.history.title.uppercased()),
            PagingItem(title: DirectMessageType.setting.title.uppercased())
        ]
        
        pagingControl.selectedIndex = currentTab.selctedIndex
        paginControlHolderView.containView(pagingControl)
    }
    
    //MARK:- IBOutlets
    @IBAction func helpBtnTapped(_sender: Any) {
        if let viewController = OnboardingController.instantiate(fromAppStoryboard: .Splash){
            viewController.isFromMainContainer = true
            self.present(viewController, animated: true, completion: nil)
        }
    }
}

extension ContainerViewController : PagingControlDelegate {
    
    func pagingControl(_ control: PagingControl, didTapButtonAtIndex index: Int) {
        guard let tab = DirectMessageType(rawValue: index) else {
            return
        }
        
        currentTab = tab        
    }
}


