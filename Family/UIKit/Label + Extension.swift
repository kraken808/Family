//
//  Label + Extension.swift
//  Family
//
//  Created by Murat Merekov on 11.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

extension UILabel{
    convenience init(text: String, font: UIFont? = .avenir20()) {
          self.init()
          
          self.text = text
          self.font = font
          self.translatesAutoresizingMaskIntoConstraints = false
      }
}
