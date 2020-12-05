//
//  UIStackView+extension.swift
//  Family
//
//  Created by Murat Merekov on 11.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
    
}
