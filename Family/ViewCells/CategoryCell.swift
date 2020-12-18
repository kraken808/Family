//
//  CategoryCell.swift
//  Family
//
//  Created by Murat Merekov on 18.12.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import UIKit
import FirebaseAuth
import SDWebImage
import Firebase
import FirebaseFirestore

class CategoryCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "CategoryCell"
    
    var friendImageView = UIImageView()
    var categoryName = UILabel(text: "Alexey", font: .laoSangamMN16())
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        backgroundColor = .white
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        setupConstraints()
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let category: MCategory = value as? MCategory else { return }
        friendImageView.sd_setImage(with: URL(string: category.imageUrl), completed: nil)
        categoryName.text = category.name
        categoryName.textColor = .black
        print("-----Category start cell------")
        print(category)
        print("-----Category end cell------")
        
        
    }
    
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryName.translatesAutoresizingMaskIntoConstraints = false
         containerView.translatesAutoresizingMaskIntoConstraints = false
    
                addSubview(containerView)
               containerView.addSubview(friendImageView)
               containerView.addSubview(categoryName)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            friendImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            friendImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            
               categoryName.topAnchor.constraint(equalTo: friendImageView.bottomAnchor),
               categoryName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//             categoryName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
               categoryName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SwiftUI
//import SwiftUI
//
//struct WaitingChatProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//
//        let tabBarVC = MenuViewController()
//
//        func makeUIViewController(context: UIViewControllerRepresentableContext<WaitingChatProvider.ContainerView>) -> MenuViewController {
//            return tabBarVC
//        }
//
//        func updateUIViewController(_ uiViewController: WaitingChatProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<WaitingChatProvider.ContainerView>) {
//
//        }
//    }
//}
