//
//  ChatTableViewCell.swift
//  Family
//
//  Created by Murat Merekov on 13.11.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import SDWebImage
class ChatTableViewCell: UITableViewCell {
   
    var fullnameLabel = UILabel(text: "", font: UIFont.init(name: "avenir", size: 18))
    var lastmsgLabel = UILabel(text: "", font: UIFont.init(name: "avenir", size: 14))
    var imageVieww: UIImageView!
    
 override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    imageVieww = UIImageView()
    imageVieww.translatesAutoresizingMaskIntoConstraints = false
   
    imageVieww.contentMode = .scaleAspectFill
    imageVieww.layer.borderWidth = 1
    imageVieww.layer.masksToBounds = false
    imageVieww.layer.borderColor = UIColor.black.cgColor
    imageVieww.layer.cornerRadius = self.frame.height/2
    imageVieww.clipsToBounds = true
    
    contentView.addSubview(imageVieww)
    contentView.addSubview(fullnameLabel)
    contentView.addSubview(lastmsgLabel)
      setupConstraints()
    }
    func setupConstraints(){
        NSLayoutConstraint.activate([
            imageVieww.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            imageVieww.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageVieww.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 3),
            imageVieww.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -3),
            imageVieww.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -340),
//            imageVieww.heightAnchor.constraint(equalToConstant: 20),
//            imageVieww.widthAnchor.constraint(equalToConstant: 20),
            
            fullnameLabel.leadingAnchor.constraint(equalTo: imageVieww.trailingAnchor, constant: 5),
            fullnameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 4),
            
            lastmsgLabel.leadingAnchor.constraint(equalTo: imageVieww.trailingAnchor, constant: 8),
            lastmsgLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 3)
            
        ])
        
    }
    func configure(muser: MChat){
        fullnameLabel.text = muser.friendUsername + " " + muser.friendLastname
        lastmsgLabel.text = muser.lastMessageContent
        imageVieww!.sd_setImage(with: URL(string: muser.friendAvatarStringURL), completed: nil)
       
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
