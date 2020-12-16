//
//  UserCell.swift
//  Family
//
//  Created by Murat Merekov on 15.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//


import UIKit
import SDWebImage

class UserCell: UICollectionViewCell, SelfConfiguringCell {
    
    let postImageView = UIImageView()
    let postName = UILabel(text: "Alexey", font: .laoSangamMN20())
    let containerView = UIView()
    
    
    static var reuseId: String = "UserCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        postName.text = post.name
        guard let url = URL(string: post.imageUrl) else { return }
        postImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func setupConstraints() {
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postName.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.backgroundColor = .red
        
        addSubview(containerView)
        containerView.addSubview(postImageView)
        containerView.addSubview(postName)
        
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
            postName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            postName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
