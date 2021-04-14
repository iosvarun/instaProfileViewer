//
//  Loader.swift
//  HotelListing
//
//  Created by Varun Kumar on 07/01/21.
//

import UIKit

class Loader: UIView {
    // MARK: IBOutlets
    
    @IBOutlet var vBackdropView: UIView!
    @IBOutlet var loderView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var textlabel: UILabel!

    
    // MARK: Properties
    // MARK: Constants
    
    static let sharedLoadingView = Loader.newInstance()
    fileprivate var count = 0
    
    // MARK: Lifecycle Methods
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.tintColor = UIColor(red: 0/255.0, green: 49/255.0, blue: 67/255.0, alpha: 1.0)

    }
    
    // MARK: Static/Class Methods
    
    public class func newInstance() -> Loader {
        let view = Bundle.main.loadNibNamed("Loader", owner: nil, options: nil)?.first as! Loader
        return view
    }
    
    public class func newInstance(title: String)  -> Loader {
        let loader = Loader.newInstance()
        return loader
    }
    
    public static func presentOnWindow() {
        presentOnWindow(message: "Loading")
    }
    
    public static func presentOnWindow(message: String) {
        DispatchQueue.main.async {
            let loader = Loader.sharedLoadingView
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                let window = sd.window
                loader.frame = (window?.frame)!
                if loader.count == 0 {
                    window?.addSubview(loader)
                }
            }
//            loader.textlabel.text = message
            loader.count = loader.count + 1
            loader.activityIndicator.startAnimating()
        }
    }
    
    public static func dismissFromWindow() {
        DispatchQueue.main.async {
            let loader = Loader.sharedLoadingView
            loader.count = loader.count - 1
            
            if loader.count <= 0 {
                loader.removeFromSuperview()
                loader.count = 0
            }
            loader.activityIndicator.stopAnimating()
        }
    }

}
