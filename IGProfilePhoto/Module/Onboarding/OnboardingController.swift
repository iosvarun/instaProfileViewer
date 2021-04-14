//
//  OnboardingController.swift
//  DirectMessage
//
//  Created by Varun Kumar on 30/03/21.
//

import UIKit

class OnboardingController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipBtn: UIButton!

    var isFromMainContainer = false
    var slides:[SlideOne] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = Theme.color(ColorCustomization.pagingGreen)
        pageControl.currentPageIndicatorTintColor = Theme.color(ColorCustomization.appThemeColor)
        pageControl.isUserInteractionEnabled = false
        view.bringSubviewToFront(pageControl)
        
        nextButton.cornerRadius(6)
        nextButton.isHidden = false
        nextButton.setTitle("Continue", for: .normal)
        nextButton.backgroundColor = Theme.color(ColorCustomization.appThemeColor)
        nextButton.addTarget(self, action: #selector(contineBtnTapped), for: .touchUpInside)
        
//        skipBtn.cornerRadius(6)
//        skipBtn.backgroundColor = Theme.color(ColorCustomization.appThemeColor)
        skipBtn.addTarget(self, action: #selector(startBtnTapped), for: .touchUpInside)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func contineBtnTapped () {
        animateTheScrollVIew()
    }
    
    @objc func startBtnTapped() {
        if isFromMainContainer {
            self.dismiss(animated: true, completion: nil)
        }else{
            AppUtils.setOnboardingLaunch(true)
            if let viewController = ContainerViewController.instantiate(fromAppStoryboard: .DirectMessage){
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
    }
    
    func animateTheScrollVIew() {
        if scrollView.contentOffset.x < self.view.bounds.width * CGFloat(slides.count) {
            UIView.animate(withDuration: 0.4, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.scrollView.contentOffset.x +=  self.view.bounds.width
            }, completion: nil)
        }
        scrollPageControl()
    }
    

    
    func createSlides() -> [SlideOne] {
        
        let slide1:SlideOne = Bundle.main.loadNibNamed("SlideOne", owner: self, options: nil)?.first as! SlideOne
        slide1.imageView.image = UIImage(named: "Intro1")
        slide1.bgImageView.image = UIImage(named: "IntroBg1")
        slide1.labelTitle.text = "Are you also tired of adding a contact number to send only one WhatsApp message?"
        slide1.labelDesc.text = "If you use Direct Message, you don’t need to save any unnecessary contacts. You can send message directly without saving the number."
        slide1.bgImageViewWidthConstraint.constant = 355
        slide1.bgImageViewHeightConstraint.constant = 292
        slide1.imageViewWidthConstraint.constant = 118
        slide1.imageViewHeightConstraint.constant = 342
        
        let slide2:SlideOne = Bundle.main.loadNibNamed("SlideOne", owner: self, options: nil)?.first as! SlideOne
        slide2.imageView.image = UIImage(named: "Intro2")
        slide2.bgImageView.image = UIImage(named: "IntroBg2")
        slide2.bgImageViewWidthConstraint.constant = 321
        slide2.bgImageViewHeightConstraint.constant = 305
        slide2.imageViewWidthConstraint.constant = 133
        slide2.imageViewHeightConstraint.constant = 317
        slide2.labelTitle.text = "Did you just receive a call from an unknown number?"
        slide2.labelDesc.text = "Copy the number and open message.The number will be detected automatically and you will be able to access the WhatsApp profile."

        
        let slide3:SlideOne = Bundle.main.loadNibNamed("SlideOne", owner: self, options: nil)?.first as! SlideOne
        slide3.imageView.image = UIImage(named: "Intro3")
        slide3.bgImageView.image = UIImage(named: "IntroBg3")
        slide3.bgImageViewWidthConstraint.constant = 321
        slide3.bgImageViewHeightConstraint.constant = 305
        slide3.imageViewWidthConstraint.constant = 133
        slide3.imageViewHeightConstraint.constant = 317
        slide3.labelTitle.text = "Do you want to save some important texts and documents for easy access?"
        slide3.labelDesc.text = "Here’s a little secret- There is no limit what one can do. You can do that by texting yourself."
        
        let slide4:SlideOne = Bundle.main.loadNibNamed("SlideOne", owner: self, options: nil)?.first as! SlideOne
        slide4.imageView.image = UIImage(named: "Intro4")
        slide4.bgImageView.image = UIImage(named: "IntroBg4")
        slide4.bgImageViewWidthConstraint.constant = 321
        slide4.bgImageViewHeightConstraint.constant = 305
        slide4.imageViewWidthConstraint.constant = 133
        slide4.imageViewHeightConstraint.constant = 317
        slide4.labelTitle.text = "Seller or Buyer? How do you send your bank details to receive payments?"
        slide4.labelDesc.text = "With the template Message feature, you can add your frequently used company information, address, product description or bank account information as quick messages and send them to your customers with one click. When you buy or sell something, you can save time."
        
        return [slide1, slide2, slide3, slide4]
    }
    
    func setupSlideScrollView(slides : [SlideOne]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
/*
    func createSlides<T>() -> T {
        let slide1:SlideOne = Bundle.main.loadNibNamed("SlideOne", owner: self, options: nil)?.first as! SlideOne
        slide1.imageView.image = UIImage(named: "Intro1")
        slide1.labelTitle.text = "Are you also tired of adding a contact number to send only one WhatsApp message?"
        slide1.labelDesc.text = "If you use Direct Message, you don’t need to save any unnecessary contacts. You can send message directly without saving the number."
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "slide2")
        slide2.labelTitle.text = "Did you just receive a call from an unknown number?"
        slide2.labelDesc.text = "Copy the number and open message.The number will be detected automatically and you will be able to access the WhatsApp profile."
        
        let slide3:SlideOne = Bundle.main.loadNibNamed("SlideOne", owner: self, options: nil)?.first as! SlideOne
        slide3.imageView.image = UIImage(named: "slide3")
        slide3.labelTitle.text = "Here’s a little secret- There is no limit what one can do. Do you want to save some important texts and documents for easy access?"
        slide3.labelDesc.text = "You can do that by texting yourself."
        
        let slide4:SlideOne = Bundle.main.loadNibNamed("SlideOne", owner: self, options: nil)?.first as! SlideOne
        slide4.imageView.image = UIImage(named: "slide4")
        slide4.labelTitle.text = "Seller or Buyer? How do you send your bank details to receive payments?"
        slide4.labelDesc.text = "With the template Message feature, you can add your frequently used company information, address, product description or bank account information as quick messages and send them to your customers with one click. When you buy or sell something, you can save time."
        
        return [slide1, slide2, slide3, slide4] as! T
    }
    
    func setupSlideScrollView<T: UIView>(slides: [T]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
 */
        
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollPageControl()
    }
    
    func scrollPageControl() {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        /*
         * below code scales the imageview on paging the scrollview
         */
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        if(percentOffset.x > 0 && percentOffset.x <= 0.33) {
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.33-percentOffset.x)/0.33, y: (0.33-percentOffset.x)/0.33)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.33, y: percentOffset.x/0.33)
        } else if(percentOffset.x > 0.33 && percentOffset.x <= 0.66) {
            slides[1].imageView.transform = CGAffineTransform(scaleX: (0.66-percentOffset.x)/0.33, y: (0.66-percentOffset.x)/0.33)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.66, y: percentOffset.x/0.66)
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 1) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.33, y: (1-percentOffset.x)/0.33)
            slides[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
        self.updateTheNextBtn()
    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
            
            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
        
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func updateTheNextBtn() {
        if pageControl.currentPage == 3 {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, animations: { () -> Void in
                    self.nextButton.setTitle("Let's Start", for: .normal)
                    self.nextButton.removeTarget(self, action: nil, for: .allEvents)
                    self.nextButton.addTarget(self, action: #selector(self.startBtnTapped), for: .touchUpInside)
                })
            }
        }else{
            DispatchQueue.main.async {
                self.nextButton.setTitle("Continue", for: .normal)
                self.nextButton.removeTarget(self, action: nil, for: .allEvents)
                self.nextButton.addTarget(self, action: #selector(self.contineBtnTapped), for: .touchUpInside)
            }
        }
    }
    
}
