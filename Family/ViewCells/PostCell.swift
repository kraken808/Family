//
//  UserCell.swift
//  Family
//
//  Created by Murat Merekov on 15.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//


import UIKit
import SDWebImage

class PostCell: UICollectionViewCell, SelfConfiguringCell {
    
    let postImageView = UIImageView()
    let postName = UILabel(text: "Alexey", font: .laoSangamMN18())
    let periodLabel = UILabel(text: "no", font: .laoSangamMN16())
    let containerView = UIView()
    
    var placeImageView1: UIImageView!
    var placeImageView2: UIImageView!
    var placeImageView3: UIImageView!
    var placeImageView4: UIImageView!
    var placeImageView5: UIImageView!
    var placeImageView6: UIImageView!
    
    static var reuseId: String = "PostCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeImageView1 = UIImageView()
        placeImageView1.image = UIImage(named: "002-user")
        
        placeImageView1.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(placeImageView1)
        
        placeImageView2 = UIImageView()
        placeImageView2.image = UIImage(named: "001-user")
        placeImageView2.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(placeImageView2)
        
        placeImageView3 = UIImageView()
        placeImageView3.image = UIImage(named: "001-user")
        placeImageView3.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(placeImageView3)
        
        placeImageView4 = UIImageView()
        placeImageView4.image = UIImage(named: "001-user")
        placeImageView4.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(placeImageView4)
        
        placeImageView5 = UIImageView()
        placeImageView5.image = UIImage(named: "001-user")
        placeImageView5.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(placeImageView5)
        
        placeImageView6 = UIImageView()
               placeImageView6.image = UIImage(named: "001-user")
               placeImageView6.translatesAutoresizingMaskIntoConstraints = false
               containerView.addSubview(placeImageView6)
        
        backgroundColor = .white
        
        setupConstraints()
        self.layer.cornerRadius = 4
        
        self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 4
        self.containerView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        postImageView.image = nil
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let post: MPost = value as? MPost else { return }
        placeImageView2.isHidden = true
                   placeImageView3.isHidden = true
                   placeImageView4.isHidden = true
                   placeImageView5.isHidden = true
        placeImageView6.isHidden = true
        postName.text = post.name
        periodLabel.text = "period: \(post.period)"
        guard let url = URL(string: post.imageUrl) else { return }
        postImageView.sd_setImage(with: url, completed: nil)
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
    
    private func setupConstraints() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postName.translatesAutoresizingMaskIntoConstraints = false
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.backgroundColor = .red
        
        addSubview(containerView)
        containerView.addSubview(postImageView)
        containerView.addSubview(postName)
        containerView.addSubview(periodLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            postName.topAnchor.constraint(equalTo: postImageView.bottomAnchor),
            postName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            postName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
          
        ])
        NSLayoutConstraint.activate([
            periodLabel.topAnchor.constraint(equalTo: postName.bottomAnchor, constant: 1),
            periodLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            placeImageView1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            placeImageView1.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
