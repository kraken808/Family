//
//  SortedPostsCell.swift
//  Family
//
//  Created by Murat Merekov on 22.12.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import SwiftUI

class SortedPostsCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "SortedPostsCell"
    var placeImageView1: UIImageView!
    var placeImageView2: UIImageView!
    var placeImageView3: UIImageView!
    var placeImageView4: UIImageView!
    var placeImageView5: UIImageView!
    var placeImageView6: UIImageView!
    
    let postImageView = UIImageView()
    let postName = UILabel(text: "User name", font: .laoSangamMN20())
    let period = UILabel(text: "How are you?", font: .laoSangamMN18())
    let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeImageView1 = UIImageView()
        placeImageView1.image = UIImage(named: "selected")
        
        placeImageView1.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeImageView1)
        
        placeImageView2 = UIImageView()
        placeImageView2.image = UIImage(named: "notsel")
        placeImageView2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeImageView2)
        
        placeImageView3 = UIImageView()
        placeImageView3.image = UIImage(named: "notsel")
        placeImageView3.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeImageView3)
        
        placeImageView4 = UIImageView()
        placeImageView4.image = UIImage(named: "notsel")
        placeImageView4.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeImageView4)
        
        placeImageView5 = UIImageView()
        placeImageView5.image = UIImage(named: "notsel")
        placeImageView5.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeImageView5)
        
        placeImageView6 = UIImageView()
               placeImageView6.image = UIImage(named: "notsel")
               placeImageView6.translatesAutoresizingMaskIntoConstraints = false
              addSubview(placeImageView6)
        backgroundColor = .white
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let post: MPost = value as? MPost else { return }
        postName.text = post.name
        period.text = post.period
        postImageView.sd_setImage(with: URL(string: post.imageUrl), completed: nil)
        
        placeImageView2.isHidden = true
        placeImageView3.isHidden = true
        placeImageView4.isHidden = true
        placeImageView5.isHidden = true
        placeImageView6.isHidden = true
        
        let members = post.numberOfUsers
              
              if members == "2"{
                  placeImageView2.isHidden = false
              }
              else if members == "3"{
                placeImageView2.isHidden = false
                  placeImageView3.isHidden = false
              }
              else if members == "4"{
                 placeImageView2.isHidden = false
                 placeImageView3.isHidden = false
                 placeImageView4.isHidden = false
              }
              else if members == "5"{
                 placeImageView2.isHidden = false
                  placeImageView3.isHidden = false
                  placeImageView4.isHidden = false
                  placeImageView5.isHidden = false

              }
              else if members == "6"{
                  placeImageView2.isHidden = false
                  placeImageView3.isHidden = false
                  placeImageView4.isHidden = false
                  placeImageView5.isHidden = false
                  placeImageView6.isHidden = false
              }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup constraints
extension SortedPostsCell {
    private func setupConstraints() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postName.translatesAutoresizingMaskIntoConstraints = false
        period.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        postImageView.backgroundColor = .orange
        gradientView.backgroundColor = .black
        
        addSubview(postImageView)
        addSubview(gradientView)
        addSubview(postName)
        addSubview(period)
        
        NSLayoutConstraint.activate([
            postImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            postImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 78),
            postImageView.widthAnchor.constraint(equalToConstant: 78)
        ])
        
        NSLayoutConstraint.activate([
            postName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            postName.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 16),
            postName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            period.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            period.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 16),
            period.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 78),
            gradientView.widthAnchor.constraint(equalToConstant: 8)
        ])
        NSLayoutConstraint.activate([
                 placeImageView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
                 placeImageView1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
             ])
             
             NSLayoutConstraint.activate([
                        placeImageView2.leadingAnchor.constraint(equalTo: placeImageView1.trailingAnchor, constant: 5),
                        placeImageView2.centerYAnchor.constraint(equalTo: placeImageView1.centerYAnchor)
                    ])
             
             
             NSLayoutConstraint.activate([
                              placeImageView3.leadingAnchor.constraint(equalTo: placeImageView2.trailingAnchor, constant: 5),
                              placeImageView3.centerYAnchor.constraint(equalTo: placeImageView2.centerYAnchor)
                          ])


             NSLayoutConstraint.activate([
                              placeImageView4.leadingAnchor.constraint(equalTo: placeImageView3.trailingAnchor, constant: 5),
                              placeImageView4.centerYAnchor.constraint(equalTo: placeImageView3.centerYAnchor)
                          ])


             NSLayoutConstraint.activate([
                              placeImageView5.leadingAnchor.constraint(equalTo: placeImageView4.trailingAnchor, constant: 5),
                              placeImageView5.centerYAnchor.constraint(equalTo: placeImageView4.centerYAnchor)
                          ])

             NSLayoutConstraint.activate([
                 placeImageView6.leadingAnchor.constraint(equalTo: placeImageView5.trailingAnchor, constant: 5),
                 placeImageView6.centerYAnchor.constraint(equalTo: placeImageView5.centerYAnchor)
             ])
        
    }
}
