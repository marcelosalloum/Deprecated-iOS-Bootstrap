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

    // MARK: - Formatting

    @IBInspectable public var lineHeight: CGFloat = 0 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight - self.font.pointSize
            paragraphStyle.alignment = self.textAlignment
            attributedString.addAttribute(NSAttributedString.Key(rawValue: "NSParagraphStyleAttributeName"),
                                          value: paragraphStyle,
                                          range: NSMakeRange(0, self.text!.count))
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

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.mainColor()
    }
}
