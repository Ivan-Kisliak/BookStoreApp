//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 12.01.25.
//

import UIKit

enum TabBarItem {
    case home
    case search
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: return UIImage(systemName: "house.fill")
        case .search: return UIImage(systemName: "magnifyingglass")
        }
    }
}

class TabBarController: UITabBarController {
    private let dataSource: [TabBarItem] = [.home, .search]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTabBarComponents()
        setupTabBar()
    }
}

//MARK: - Settings View
private extension TabBarController {
    func buildTabBarComponents() {
        viewControllers = dataSource.map {
            switch $0 {
            case .home:
                let collectionViewController = CollectionViewController()
                collectionViewController.bookTypeManager = buildTypeManager()
                return UINavigationController(rootViewController: collectionViewController)
            case .search:
                return UINavigationController(rootViewController: MultipleSectionViewController())
            }
        }
    }
    
    func buildTypeManager() -> IBookTypeManager {
        let bookTypeManger = BookTypeManager()
        return bookTypeManger
    }
    
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        viewControllers?.enumerated().forEach { index, viewController in
            viewController.tabBarItem.title = dataSource[index].title
            viewController.tabBarItem.image = dataSource[index].icon
        }
    }
}
