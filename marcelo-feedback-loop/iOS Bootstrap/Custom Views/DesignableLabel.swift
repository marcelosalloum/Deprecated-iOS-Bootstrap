//
//  DesignableLabel.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

@IBDesignable
public class DesignableLabel: UILabel {

    // MARK: - Custom Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    open override func prepareForInterfaceBuilder() {   // Used for updating the Interface Builder
        super.prepareForInterfaceBuilder()
        commonInit()
    }

    fileprivate func commonInit() {
        self.font = UIFont.withSize(CGFloat.random(in: 10...20))
        self.tintColor = UIColor.mainColor()
    }

    // MARK: - Formatting
    @IBInspectable public var lineHeight: CGFloat = 0 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight - self.font.pointSize
            paragraphStyle.alignment = self.textAlignment
            var count = 0
            if let text = self.text {
                count = text.count
            }
            attributedString.addAttribute(NSAttributedString.Key(rawValue: "NSParagraphStyleAttributeName"),
                                          value: paragraphStyle,
                                          range: NSRange(0...count))
            self.attributedText = attributedString
        }
    }

    @IBInspectable public var spacing: CGFloat = 0 {
        didSet {
            let attributes = [NSAttributedString.Key.kern: spacing] as [NSAttributedString.Key: Any]
            self.attributedText = NSAttributedString(string: self.text!, attributes: attributes)
        }
    }

    // MARK: - Shapes

    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }

    @IBInspectable open var textTheme: Int = TextTheme.title.rawValue
}

public enum TextTheme: Int {
    case title = 0
    case titleQuote
    case card
    case cardQuote
    case cardDetail
    case cardFooter
    case questionSubtitle
    case quesionCard
}

public enum ColorTheme: Int {
    case professional = 0
    case personal
    case romantic
}

public struct LabelSetup {
    var textTheme: TextTheme!
    var colorTheme: ColorTheme!

    init(labelType: TextTheme, appTheme: ColorTheme) {
        self.textTheme = labelType
        self.colorTheme = appTheme
    }

    var color: UIColor {
        switch colorTheme! {
        case ColorTheme.professional:
            switch textTheme! {
            case TextTheme.title: return .white  // professional
            case TextTheme.titleQuote: return .white
            case TextTheme.card: return .white
            case TextTheme.cardQuote: return .white
            case TextTheme.cardDetail: return .white
            case TextTheme.cardFooter: return .white
            case TextTheme.questionSubtitle: return .white
            case TextTheme.quesionCard: return .white
            }
        case ColorTheme.personal:
            switch textTheme! {
            case TextTheme.title: return .white  // professional
            case TextTheme.titleQuote: return .white
            case TextTheme.card: return .white
            case TextTheme.cardQuote: return .white
            case TextTheme.cardDetail: return .white
            case TextTheme.cardFooter: return .white
            case TextTheme.questionSubtitle: return .white
            case TextTheme.quesionCard: return .white
            }
        case ColorTheme.romantic:
            switch textTheme! {
            case TextTheme.title: return .white  // professional
            case TextTheme.titleQuote: return .white
            case TextTheme.card: return .white
            case TextTheme.cardQuote: return .white
            case TextTheme.cardDetail: return .white
            case TextTheme.cardFooter: return .white
            case TextTheme.questionSubtitle: return .white
            case TextTheme.quesionCard: return .white
            }
        }
    }

    var fontSize: UIFont? {
        switch textTheme! {
        case TextTheme.title: return UIFont.withSize(15)
        case TextTheme.titleQuote: return UIFont.withSize(15)
        case TextTheme.card: return UIFont.withSize(15)
        case TextTheme.cardQuote: return UIFont.withSize(15)
        case TextTheme.cardDetail: return UIFont.withSize(15)
        case TextTheme.cardFooter: return UIFont.withSize(15)
        case TextTheme.questionSubtitle: return UIFont.withSize(15)
        case TextTheme.quesionCard: return UIFont.withSize(15)
        }
    }
}
