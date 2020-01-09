//
//  Indexer.swift
//  Top Headlines
//
//  Created by Rishi pal on 07/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation
import UIKit

struct Indexer {
    enum RootView {
        case welcome
        case home
    }
    
    func getRootView()-> RootView {
        let userData = IKeyChain.load(key: AppConstants.UserInfo.key)
        if userData != nil {
            return .home
        }
        return .welcome
        
    }
    
    func setRootView(for window: UIWindow) {
        let navViewController = UIViewController.get(with: "NavigationViewController", storyboard: AppConstants.Storyboard.main)
        var viewController: UIViewController?
        let rootViewType = getRootView()
        switch rootViewType {
        case .home:
            viewController = HeadlinesTableViewController.get(with: AppConstants.ViewControllerStotyboardId.headlinesTableViewController, storyboard: AppConstants.Storyboard.main)
        case .welcome:
            viewController = WelcomeViewController.get(with: AppConstants.ViewControllerStotyboardId.welcomeViewController, storyboard: AppConstants.Storyboard.main)
        }
        
        guard let someNavCV = navViewController as? UINavigationController else {
            fatalError("NavigationViewController not find, check it")
        }
        guard let someInitialVC = viewController else {
            fatalError("ViewController not find, check it")
        }
        
        someNavCV.viewControllers = [someInitialVC]
        window.rootViewController = someNavCV
        
    }
    
    func setWelcomeAsRoot() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let navViewController = UIViewController.get(with: "NavigationViewController", storyboard: AppConstants.Storyboard.main)
        var viewController: UIViewController?
      
        viewController = WelcomeViewController.get(with: AppConstants.ViewControllerStotyboardId.welcomeViewController, storyboard: AppConstants.Storyboard.main)
        
        guard let someNavCV = navViewController as? UINavigationController else {
            fatalError("NavigationViewController not find, check it")
        }
        guard let someInitialVC = viewController else {
            fatalError("ViewController not find, check it")
        }
        
        someNavCV.viewControllers = [someInitialVC]
        appDelegate.window?.rootViewController = someNavCV
    }
    
}
