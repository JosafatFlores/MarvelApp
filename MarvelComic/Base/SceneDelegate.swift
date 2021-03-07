//
//  SceneDelegate.swift
//  MarvelComic
//
//  Created by Test on 04/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            Sesion.instance.typeDevice = "phone"
            Sesion.instance.navigationBarSize = 43
            break
        // It's an iPhone
        case .pad:
            Sesion.instance.typeDevice = "pad"
            Sesion.instance.navigationBarSize = 50
            break
        case .unspecified:
            Sesion.instance.typeDevice = "unspecified"
            break
        case .tv:
            Sesion.instance.typeDevice = "tv"
            break
        case .carPlay:
            Sesion.instance.typeDevice = "carplay"
            break
        case .mac:
            Sesion.instance.typeDevice = "mac"
        @unknown default:
            Sesion.instance.typeDevice = "default"
        }
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows[0]
            Sesion.instance.topPading = window.safeAreaInsets.top + Sesion.instance.navigationBarSize
            Sesion.instance.bottomPadding = window.safeAreaInsets.bottom
        }
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

