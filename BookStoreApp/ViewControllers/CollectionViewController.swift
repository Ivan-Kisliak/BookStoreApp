//
//  CollectionViewController.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 12.12.24.
//

import UIKit

class CollectionViewController: UIViewController {
    var bookTypeManager: IBookTypeManager?
    
    private var collectionView: UICollectionView!
    private var diffableDataSource: UICollectionViewDiffableDataSource<BookType, Book>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollectionView()
        configureDataSource()
        applyInitialData()
    }
}

// MARK: - Setting View
private extension CollectionViewController {
    func setupView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.register(
            CustomBookCell.self,
            forCellWithReuseIdentifier: CustomBookCell.identifier
        )
        
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        
        collectionView.register(
            BadgeView.self,
            forSupplementaryViewOfKind: ElementKind.badge,
            withReuseIdentifier: BadgeView.reuseIdentifier
        )
        
        collectionView.backgroundColor = .black
        view.addSubview(collectionView)
    }
}

// MARK: - Setting Layout
private extension CollectionViewController {
    func createLayout() -> UICollectionViewLayout {
        let item = createItemWithBadge()
        let group = createGroup(item: item)
        let header = createHeader()
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 30,
            leading: 5,
            bottom: 50,
            trailing: 5
        )
        section.boundarySupplementaryItems = [header]
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func createItemWithBadge() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        )
        
        let badge = createBadge()
        
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize,
            supplementaryItems: [badge]
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 5,
            bottom: 5,
            trailing: 10
        )
        return item
    }
    
    func createBadge() -> NSCollectionLayoutSupplementaryItem {
        let supplementaryItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(25)
        )
        
        let constraints = NSCollectionLayoutAnchor(
            edges: [.top, .leading],
            absoluteOffset: CGPoint(x: 0, y: -25)
        )
        
        return NSCollectionLayoutSupplementaryItem(
            layoutSize: supplementaryItemSize,
            elementKind: ElementKind.badge,
            containerAnchor: constraints
        )
    }
    
    func createGroup(item: NSCollectionLayoutItem) -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/5)
        )
        
        return NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
    }
    
    func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
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

// MARK: - Settings DiffableDataSource
private extension CollectionViewController {
    func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<BookType, Book>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, book in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CustomBookCell.identifier,
                    for: indexPath
                ) as? CustomBookCell else {
                    return UICollectionViewCell()
                }
                
                cell.configure(imageName: book.image, text: book.title)
                return cell
            }
        )
        
        diffableDataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath
                ) as? SectionHeaderView
                
                let section = self.diffableDataSource.snapshot().sectionIdentifiers[indexPath.section]
                header?.configure(text: section.type, textColor: .white)
                return header
                
            case ElementKind.badge:
                let badge = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: BadgeView.reuseIdentifier,
                    for: indexPath
                ) as? BadgeView
                
                let section = self.diffableDataSource.snapshot().sectionIdentifiers[indexPath.section]
                let book = section.books[indexPath.item]
                badge?.configureBadge(isHidden: book.isNew)
                return badge
                
            default:
                return nil
            }
        }
    }
    
    func applyInitialData() {
        guard let bookTypes = bookTypeManager?.getBookTypes() else { return }
        
        var snapshot = NSDiffableDataSourceSnapshot<BookType, Book>()
        snapshot.appendSections(bookTypes)
        
        bookTypes.forEach { snapshot.appendItems($0.books, toSection: $0) }
        
        diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
}

