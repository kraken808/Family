//
//  MainViewController.swift
//  Family
//
//  Created by Murat Merekov on 31.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

 
enum Wrapper: Hashable {
    case category(MCategory)
    case post(MPost)
}

class MainViewController: UIViewController {
    
    var users = [MUser]()
    var items = [MPost]()
    var categories = [MCategory]()
    var wrapper = [Wrapper]()
    private var postListener: ListenerRegistration?
    private var categoryListener: ListenerRegistration?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Wrapper>!
   
    enum Section: Int, CaseIterable {
         case category
        case posts
       
        func description() -> String {
            switch self {
            case .posts:
                return "Families"
            
            case .category:
                return "Categories"
            }
        }
    }
    
    private let currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        title = currentUser.name
    }
    
    deinit {
        postListener?.remove()
        categoryListener?.remove()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupCollectionView()
        createDataSource()
        
     
        
//        postListener = ListenerService.shared.usersObserve(users: users, completion: { (result) in
//            switch result {
//            case .success(let users):
//                self.users = users
//                self.reloadData(with: nil)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        })
        categoryListener = ListenerService.shared.categoryObserve(categories: categories, completion: { (result) in
                     switch result {
                                          case .success(let categories):
                                
                                            for it in categories{
                                                self.wrapper.append(contentsOf: [.category(it)])
                                              }
        //                                      print("------Category starts-------\n")
        //                                    print(self.wrapper)
        //                                      print("------Category ends-------\n")
                                              self.reloadData(searchText: nil)
                                          case .failure(let error):
                                              print(error.localizedDescription)
                                          }
                })
        
        postListener = ListenerService.shared.itemsObserve(items: items, completion: { (result) in
             switch result {
                       case .success(let items):
                           
                        
                           
                           for post in items{
                            self.wrapper.append(contentsOf: [.post(post)])
                           }
//                                 print("------Posts begin-------\n")
//                                 print(temp)
//                                 print("------Posts end-------\n")
                           self.reloadData(searchText: nil)
                       case .failure(let error):
                           print(error.localizedDescription)
                       }
        })
        
        
        
        
       
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .mainWhite()
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        collectionView.delegate = self
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .mainWhite()
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func reloadData(searchText: String?) {
        let filtered = items.filter { (post) -> Bool in
            post.contains(filter: searchText)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Wrapper>()
        snapshot.appendSections([.category,.posts])
        var wrapperCtgry = [Wrapper]()
        var wrapperPst = [Wrapper]()
//        print("----------Wrapper [] start---------\n")
//        print(self.wrapper)
//        print("----------Wrapper [] end---------\n")
        for it in self.wrapper{
            switch it{
                
            case .category(let ctgry):
                wrapperCtgry.append(contentsOf: [.category(ctgry)])
            case .post(let pst):
                wrapperPst.append(contentsOf: [.post(pst)])
            }
        }
        snapshot.appendItems(wrapperCtgry,toSection: .category)
       
            snapshot.appendItems(wrapperPst,toSection: .posts)
        
//                    print("----------Wrapper start---------\n")
//                                  print(wrapper)
//                                  print("----------Wrapper end---------\n")
        

        dataSource?.apply(snapshot, animatingDifferences: true)

    }
}


// MARK: - Data Source
extension MainViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Wrapper>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, categ) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch categ{
                
            case .category(let ctgry):
//                print("----------Ctgry---------\n")
//                print(ctgry)
//                print("----------Ctgry---------\n")
                return self.configure(collectionView: collectionView, cellType: CategoryCell.self, with: ctgry, for: indexPath)
            case .post(let pst):
//                print("----------Pst Start--------\n")
//                               print(pst)
//                               print("----------Pst end---------\n")
                return self.configure(collectionView: collectionView, cellType: UserCell.self, with: pst, for: indexPath)
            }

//            switch section {
//            case .posts:
//                return self.configure(collectionView: collectionView, cellType: UserCell.self, with: categ, for: indexPath)
//            case .category:
//                return self.configure(collectionView: collectionView, cellType: CategoryCell.self, with: categ, for: indexPath)
//            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section header") }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
//            let items = self.dataSource.snapshot().itemIdentifiers(inSection: .posts)
            sectionHeader.configure(text: section.description(),
                                    font: .laoSangamMN20(),
                                    textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            return sectionHeader
        }
    }
}

// MARK: - Setup layout
extension MainViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (senctionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: senctionIndex) else {
                fatalError("Unknown section kind")
            }
        
            switch section {
            case .posts:
                return self.createUsersSection()
            case .category:
                return self.createCategory()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createCategory() -> NSCollectionLayoutSection {
           
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                 heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                               heightDimension: .absolute(120))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
           let section = NSCollectionLayoutSection(group: group)
           section.interGroupSpacing = 20
           section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
           section.orthogonalScrollingBehavior = .continuous
     
           let sectionHeader = createSectionHeader()
           section.boundarySupplementaryItems = [sectionHeader]
           return section
       }
    
    private func createUsersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(15)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 15, bottom: 0, trailing: 15)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        return sectionHeader
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        reloadData(with: searchText,)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let user = self.dataSource.itemIdentifier(for: indexPath) else { return }
//        
////        let profileVC = PersonProfileViewController(user: user)
////        present(profileVC, animated: true, completion: nil)
//    }
}
