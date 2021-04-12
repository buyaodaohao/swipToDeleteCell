//
//  AppDelegate.swift
//  DeleteCellDemo
//
//  Created by 云联智慧 on 2021/4/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds);
        window?.rootViewController = UINavigationController.init(rootViewController: KKGDemoListViewController());
        window?.makeKeyAndVisible();
        return true
    }

    


}

