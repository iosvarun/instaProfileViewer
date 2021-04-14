import UIKit


@objc class PagingItem: NSObject {
    var title: String
    let icon: UIImage?
    let highlightedIcon: UIImage?

    init(title: String) {
        self.title = title
        self.icon = nil
        self.highlightedIcon = nil
    }

    init(title: String, icon: UIImage, highlightedIcon: UIImage) {
        self.title = title
        self.icon = icon
        self.highlightedIcon = highlightedIcon
    }
}


@objc protocol PagingControlDelegate {
    @objc optional func pagingControl(_ control: PagingControl, didTapButtonAtIndex index: Int)
}


class PagingControl: UIView {
    weak var delegate: PagingControlDelegate?

    var menuSpacing: CGFloat = 15
    let indicatorViewHeight: CGFloat = 3
    var font: UIFont?
    var titleColor: UIColor = UIColor.black {
        didSet {
            for button in titleViews {
                button.setTitleColor(titleColor, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
            }
        }
    }
    var selectedTitleColor: UIColor? {
        didSet {
            if let color = selectedTitleColor {
                for button in titleViews {
                    button.setTitleColor(color, for: .selected)

                }
            }
        }
    }
    var titleFont: UIFont = Theme.Font.regular(FontSize.normalSmall.rawValue) {
        didSet {
            for button in titleViews {
                button.titleLabel?.font = titleFont
            }
        }
    }
    
    var selectedTitleFont: UIFont? {
        didSet {
            if let font = selectedTitleFont {
                for button in titleViews {
                    button.titleLabel?.font = font
                }
                
            }
        }
    }
    
    var indicatorViewColor: UIColor = UIColor.clear {
        didSet {
            indicatorView.backgroundColor = indicatorViewColor
        }
    }
    var dividerColor: UIColor = UIColor.clear {
        didSet {
            dividerView.backgroundColor = dividerColor
        }
    }

    private var scrollView: UIScrollView!
    private var indicatorView: UIView!
    private var dividerView: UIView!

    var scrollable: Bool {
        return scrollView.contentSize.width > frame.width
    }

    var showIcons: Bool = false
    var titleViews: [UIButton] = []
    var pagingItems: [PagingItem] = [] {
        didSet {
            generateTitleViews()
        }
    }

    var selectedIndex: Int = 0 {
        didSet {
            if oldValue != selectedIndex {
                updateSelectedIndex()
            }
        }
    }

    private let iconImageViewTag = 1000

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        var bounds = frame
        bounds.origin = CGPoint()

        scrollView = UIScrollView(frame: bounds)
        scrollView.frame = bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        indicatorView = UIView(frame: CGRect(x: 0, y: frame.height - indicatorViewHeight, width: 0, height: indicatorViewHeight))
        indicatorView.backgroundColor = indicatorViewColor
        scrollView.addSubview(indicatorView)

        let pixel = 1 / UIScreen.main.scale
        dividerView = UIView(frame: CGRect(x: 0, y: bounds.size.height - pixel, width: bounds.width, height: pixel))
        dividerView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]

        addSubview(scrollView)
        insertSubview(dividerView, belowSubview: scrollView)
        
        let topShadow = EdgeShadowLayer(forView: dividerView, edge: .Top, shadowRadius: 10.0, toColor: Theme.color(ColorCustomization.whiteColor), fromColor: Theme.color(ColorCustomization.shadowColor))
        dividerView.layer.addSublayer(topShadow)

        applyTheme()
    }

    private func applyTheme() {
        backgroundColor = .white //Theme.color(.menuBarBackground)
        indicatorViewColor = UIColor(hex: 0xF4CC63) //Theme.color(.menuBarIndicator)
        titleColor = Theme.color(ColorCustomization.appThemeColor)//UIColor(hex: 0x21282D) //Theme.color(.menuBarTitle)
        dividerColor = UIColor(hex: 0xDDDDE5) //Theme.color(.menuBarDivider)
        font = Theme.Font.regular(FontSize.normalSmall.rawValue)
    }

    private func generateTitleViews() {
        for view in titleViews {
            view.removeFromSuperview()
        }

        titleViews = []

        for (index, item) in pagingItems.enumerated() {
            let button = UIButton()
            button.tag = index
            button.setTitle(item.title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = titleFont
            if let selectedTitleColor = self.selectedTitleColor {
                button.setTitleColor(selectedTitleColor, for: .selected)
                button.titleLabel?.font = selectedTitleFont
            }

//            if let font = self.font {
//                button.titleLabel?.font = titleFont
//                button.titleLabel?.adjustsFontSizeToFitWidth = true
//                button.titleLabel?.minimumScaleFactor = 0.8
//
//                if #available(iOS 9.0, *) {
//                    button.titleLabel?.allowsDefaultTighteningForTruncation = true
//                }
//            }

            if showIcons {
                button.titleEdgeInsets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)

                if let icon = item.icon, let highlightedIcon = item.highlightedIcon {
                    let imageView = UIImageView(image: icon, highlightedImage: highlightedIcon)
                    imageView.tag = iconImageViewTag
                    imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
                    button.addSubview(imageView)
                }
            }

            scrollView.addSubview(button)
            titleViews.append(button)

            button.addTarget(self, action: #selector(PagingControl.buttonTapped(_:)), for: .touchUpInside)
        }

        setNeedsLayout()
        updateSelectedIndex()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var xOffset: CGFloat = 0
        for button in titleViews {
            button.sizeToFit()

            let textHeight = button.frame.height
            button.frame.origin.x = xOffset
            button.frame.size.height = scrollView.frame.size.height
            button.frame.size.width += menuSpacing * 2

            if let imageView = button.viewWithTag(iconImageViewTag) as? UIImageView {
                let imageHeight = imageView.image?.size.height ?? 0
                let originX = (button.frame.width - imageView.frame.width) / 2
                let originY = 4 + (button.frame.height - textHeight - imageHeight) / 2
                imageView.frame.origin = CGPoint(x: originX, y: originY)
            }

            xOffset += button.frame.width
        }

        if xOffset < self.frame.width {
            let width = ceil((self.frame.width / CGFloat(titleViews.count)) * 2) / 2
            for (i, button) in titleViews.enumerated() {
                button.frame.origin.x = CGFloat(i) * width
                button.frame.size.width = width
            }

            xOffset = scrollView.frame.width
        }

        var indicatorViewFrame = indicatorView.frame
        indicatorViewFrame.origin.x = titleViews[selectedIndex].frame.origin.x
        indicatorViewFrame.size.width = titleViews[selectedIndex].frame.size.width
        indicatorView.frame = indicatorViewFrame
        scrollView.contentSize = CGSize(width: xOffset, height: scrollView.frame.size.height)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        selectedIndex = index
        delegate?.pagingControl?(self, didTapButtonAtIndex: index)
    }

    private func updateSelectedIndex() {
        layoutIfNeeded()

        var frame = CGRect()
        let barWidth = bounds.width

        for i in 0 ..< titleViews.count {
            let selected = i == selectedIndex
            titleViews[i].isSelected = selected
            if selected {
                frame = titleViews[i].frame
            }

            if let iconImageView = titleViews[i].viewWithTag(iconImageViewTag) as? UIImageView {
                iconImageView.isHighlighted = selected
            }
        }

        frame.origin.y = scrollView.frame.height - indicatorView.frame.height
        frame.size.height = indicatorView.frame.height

        let maxOffset = scrollView.contentSize.width - barWidth
        let offsetX = min(maxOffset, max(0, frame.origin.x - floor((barWidth - frame.width) / 2)))
        let offset = CGPoint(x: offsetX, y: 0)
        scrollView.setContentOffset(offset, animated: true)

        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.beginFromCurrentState], animations: {
            self.indicatorView.frame = frame
        }, completion: nil)
        
    }

    func wiggle() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            self.scrollView.setContentOffset(CGPoint(x: -50, y: 0), animated: false)
        }, completion: nil)

        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
            self.scrollView.setContentOffset(CGPoint(), animated: false)
        }, completion: nil)
    }
}
