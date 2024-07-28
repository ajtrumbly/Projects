//
//  SceneDelegate.swift
//  PortfolioApp
//
//  Created by Austin Trumbly on 7/28/24.
//

import Foundation
import SwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func windowScene(
        _ windowScene: UIWindowScene,
        performActionFor shortcutItem: UIApplicationShortcutItem,
        completionHandler: @escaping (Bool) -> Void
    ) {
        guard let url = URL(string: shortcutItem.type) else {
            completionHandler(false)
            return
        }
        
        windowScene.open(url, options: nil, completionHandler: completionHandler)
    }
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let shortCutItem = connectionOptions.shortcutItem {
            if let url = URL(string: shortCutItem.type) {
                scene.open(url, options: nil)
            }
        }
    }
}
