//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by  Ivan Kiskyak on 12.12.24.
//

import UIKit

enum Scene {
    case collection
    case multipleSection
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let rootViewController = UINavigationController(
            rootViewController: TabBarController()
        )
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
}

private extension SceneDelegate {
    func buildTypeManager() -> IBookTypeManager {
        let bookTypeManger = BookTypeManager()
        return bookTypeManger
    }
}

private extension SceneDelegate {
    func assembly(scene: Scene) -> UIViewController {
        switch scene {
        case .collection:
            let collectionViewController = CollectionViewController()
            collectionViewController.bookTypeManager = buildTypeManager()
            return collectionViewController
        case .multipleSection:
            return MultipleSectionViewController()
        }
    }
}



