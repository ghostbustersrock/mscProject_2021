//
//  AppDelegate.swift
//  mscProject_2021
//
//  Created by Luca Santarelli on 23/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //---------------------------------------------------------------------------
        /* Title: Keyboard manager to avoid keyboard from hiding UI content, built in Swift
        Author: Iftekhar Qurashi (hackiftekhar)
        Date: 2020
        Code version: v6.5.0 Release, 26 Sep. 2019
        Availability: https://github.com/hackiftekhar/IQKeyboardManager.git */
        IQKeyboardManager.shared.enable = true
        //---------------------------------------------------------------------------
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

