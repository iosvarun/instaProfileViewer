//
//  DetailedHistoryViewController.swift
//  DirectMessage
//
//  Created by MOHIT PAREEK on 14/01/21.
//

import UIKit

class DetailedHistoryViewController: UIViewController, ViewControllerFromStoryboard {

    static let storyboardName = "DirectMessage"
//    var history: MessageHistory?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarView: CustomNavigationView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpInitialUI()
    }
   
    fileprivate func setUpInitialUI() {
        let nib = UINib(nibName: "DetailedHistoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DetailedHistoryTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80
        navBarView.delegate = self
        navBarView.backButton.isHidden = false
        navBarView.backButton.setTitle("9999999999", for: .normal)
        messageTextField.backgroundColor = Theme.color(ColorCustomization.viewBgColor)
        sendButton.backgroundColor = Theme.color(ColorCustomization.appThemeColor)
        sendButton.cornerRadius(6)
        messageTextField.delegate = self
        
        let bottomShadow = EdgeShadowLayer(forView: bottomView, edge: .Top, shadowRadius: 10, toColor: Theme.color(ColorCustomization.whiteColor), fromColor: Theme.color(ColorCustomization.shadowColor))
        bottomView.layer.addSublayer(bottomShadow)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageTextField.resignFirstResponder()
    }
    
}


extension DetailedHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedHistoryTableViewCell") as! DetailedHistoryTableViewCell
        if indexPath.row%2 == 0 {
//            cell.configureCell(typeOfMessage: TypeOfMessage.whatsapp, historyObj: history!)
        }else {
//            cell.configureCell(typeOfMessage: TypeOfMessage.TextMessage, historyObj: history!)
        }
        
        return cell
        
    }
    
}

extension DetailedHistoryViewController: CustomNavigationViewProtocol {
    func rightBtnTapped() {
        
    }
    
    func backbtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
extension DetailedHistoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
        return true
    }
}
