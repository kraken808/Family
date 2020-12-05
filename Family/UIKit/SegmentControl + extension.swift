//
//  SegmentControl + extension.swift
//  Family
//
//  Created by Murat Merekov on 11.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    
    convenience init(first: String, second: String) {
        self.init()
        self.insertSegment(withTitle: first, at: 0, animated: true)
        self.insertSegment(withTitle: second, at: 1, animated: true)
        self.selectedSegmentIndex = 0
    }
}
