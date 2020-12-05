//
//  SelfConfiguringCell.swift
//  Family
//
//  Created by Murat Merekov on 15.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
