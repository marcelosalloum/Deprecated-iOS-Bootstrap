//
//  PersonView.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 05/02/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//

import UIKit

@IBDesignable
open class DesignableButton: UIButton {

    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable open var borderWidth: CGFloat = 3 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }

    @IBInspectable open var spacingHorizontal: CGFloat = 0 {
        didSet {
            self.imageEdgeInsets = UIEdgeInsets(top: spacingVertical, left: 0, bottom: 0, right: spacingHorizontal)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacingHorizontal, bottom: spacingVertical, right: 0)
        }
    }

    @IBInspectable open var spacingVertical: CGFloat = 0 {
        didSet {
            self.imageEdgeInsets = UIEdgeInsets(top: spacingVertical, left: 0, bottom: 0, right: spacingHorizontal)
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacingHorizontal, bottom: spacingVertical, right: 0)
        }
    }

    @IBInspectable open var spacing: CGFloat = 0 {
        didSet {
            let attributes = [NSAttributedString.Key.kern : spacing] as [NSAttributedString.Key : Any]
            self.titleLabel?.attributedText = NSAttributedString(string: (self.titleLabel?.text!)!, attributes: attributes)
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .gray
    }

}
