//
//  AppConstants.swift
//  Top Headlines
//
//  Created by Rishi pal on 07/01/20.
//  Copyright © 2020 Rishi pal. All rights reserved.
//

import Foundation

struct AppConstants {
    struct UserInfo {
        static let key:String = "top_headlines_user_info_key"
    }
    struct  Storyboard {
       static let main = "Main"
    }
    struct ViewControllerStotyboardId {
        static let navigationViewController = "NavigationViewController"
        static let welcomeViewController = "WelcomeViewController"
        static let signInOrSignUpViewController  = "SignInOrSignUpViewController"
        static let headlinesTableViewController = "HeadlinesTableViewController"
        static let headlineDetailsTableViewController = "HeadlineDetailsTableViewController"
    }
    
    struct ServerURL {
        static let hedlineURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9f27cfcb41c44753a819749576e11ae1"
    }
}
