//
//  CollectionViewController.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 12.12.24.
//

import UIKit

class CollectionViewController: UIViewController {
    private let reuseIdentifier = "reuseIdentifier"
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollectionView()
    }
    
}

//MARK: - Setting View
private extension CollectionViewController {
    func setupView() {
        view.backgroundColor = .black
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
    }
}

//MARK: - Setting Layout
private extension CollectionViewController {
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/5)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 50,
                                                        leading: 5,
                                                        bottom: 5,
                                                        trailing: 5)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .systemGray
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
}
