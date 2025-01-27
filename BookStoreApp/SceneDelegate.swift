//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 12.12.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let allTabBarItems = TabBarItem.allTabBarItems
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = TabBarController()
        
        tabBarController.viewControllers?.enumerated().forEach({ index, vc in
            guard let navVC = vc as? UINavigationController else { return }
            pushViewController(index: index, controller: navVC)
        })
        
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
    }
}

private extension SceneDelegate {
    func pushViewController(index: Int, controller: UINavigationController) {
        let bookTypeManager = BookTypeManager()
        
        switch allTabBarItems[index] {
        case .home:
            let collecionVC = CollectionViewController()
            collecionVC.bookTypeManager = bookTypeManager
            controller.pushViewController(collecionVC, animated: false)
        case .search:
            let multiSectionVC = MultipleSectionViewController()
            controller.pushViewController(multiSectionVC, animated: false)
        }
    }
}




