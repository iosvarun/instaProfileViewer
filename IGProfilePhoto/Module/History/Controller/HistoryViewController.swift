//
//  HistoryViewController.swift
//  DirectMessage
//
//  Created by Varun Kumar on 22/12/20.
//

import UIKit
import SwipeCellKit
class HistoryViewController: UIViewController, ViewControllerFromStoryboard {
    static let storyboardName = "DirectMessage"
//    var historyDataSource: [MessageHistory]?
    @IBOutlet weak var noHistoryMsgLabel: UILabel!
    @IBOutlet weak var slideTheCardToDeleteTheLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "historyCell")
        
        self.historyTableView.rowHeight = UITableView.automaticDimension
        self.historyTableView.estimatedRowHeight = 80
        self.historyTableView.dataSource = self
        self.historyTableView.delegate = self
        self.analyticsEventHistoryPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        historyDataSource = MessageHistory.getAllMessage()
        reloadTableView()
//        print("HistoryViewController historyDataSource count \(String(describing: historyDataSource?.count))")
    }
    
    func reloadTableView() {
//        noHistoryMsgLabel.isHidden = historyDataSource?.count == 0 ? false : true
//        slideTheCardToDeleteTheLabel.isHidden = historyDataSource?.count != 0 ? false : true
        historyTableView.reloadData()
    }
}



extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
//        return historyDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryTableViewCell
        historyCell.delegate = self
//        if let historyObj = historyDataSource?[indexPath.row] {
//            historyCell.configureCell(historyObj: historyObj)
//        }
        return historyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        let detailedHistoryController = DetailedHistoryViewController.viewController()
        if let historyObj = historyDataSource?[indexPath.row] {
            detailedHistoryController.history = historyObj
        }
        navigationController?.pushViewController(detailedHistoryController, animated: true)
 */
    }
}

extension HistoryViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

           let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
               // handle action by updating model with deletion
//            self.analyticEventDeleteHistoryMessage(number: (self.historyDataSource?[indexPath.row].phoneNumber)!, textMessage: (self.historyDataSource?[indexPath.row].messageTxt)!)
//            MessageHistory.deleteHistoryMessage(messageId: (self.historyDataSource?[indexPath.row].messageId)!)
//            self.historyDataSource?.remove(at: indexPath.row)
            self.reloadTableView()
           }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = Color.greenColor
           return [deleteAction]
    }
    
}

extension HistoryViewController {
    
    func analyticsEventHistoryPage() {
        let attributes = NSMutableDictionary()
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.historyPage(), attributes: attributes)
    }
    
    func analyticEventDeleteHistoryMessage(number: String, textMessage: String) {
        let attributes = NSMutableDictionary()
        attributes.setValue(number, forKey: AnalyticsEventAttributes.phoneNumber())
        attributes.setValue(textMessage, forKey: AnalyticsEventAttributes.message())
        FirebaseManager.shared.trackFireBaseEvent(AnalyticsEventKey.deleteHistory(), attributes: attributes)
    }
}

struct History {
    let number: String
    let message: String
    
    init(number: String, message: String) {
        self.number = number
        self.message = message
    }
}
