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
    
    static let allTabBarItems: [TabBarItem] = [.home, .search]
}

final class TabBarController: UITabBarController {
    private var dataSource: [TabBarItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
}

//MARK: - Settings View
private extension TabBarController {
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
        
        let controllers: [UINavigationController] = TabBarItem.allTabBarItems.map { item in
            let navControllers = UINavigationController()
            
            navControllers.tabBarItem.title = item.title
            navControllers.tabBarItem.image = item.icon
            
            return navControllers
        }
        
        setViewControllers(controllers, animated: true)
    }
}
