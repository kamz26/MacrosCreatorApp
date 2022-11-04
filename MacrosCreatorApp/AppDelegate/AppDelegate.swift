//
//  AppDelegate.swift
//  MacrosCreatorApp
//
//  Created by Abhishek Kashyap on 04/11/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let initialVc = MacrosCreatorViewController.initFromNib()
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.rootViewController = UINavigationController(rootViewController: initialVc)
    self.window!.makeKeyAndVisible()
    return true
  }

}

