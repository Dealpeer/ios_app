//
//  AppDelegate.swift
//  DealPeer
//
//  Created by Artem Katlenok on 19/05/2018.
//  Copyright © 2018 Artem Katlenok. All rights reserved.
//

import UIKit

// Fabric and Crashlytics
import Fabric
import Crashlytics

// Google Maps
import GoogleMaps

// Google Sign In
import GoogleSignIn

let kGoogleMapsAPIKey = "AIzaSyDZJ90zqsINYiEdDFx2O81OqQ30uIRumMI"
let kGoogleSignInAPIKey = "100489622032-3qrcu4oo42oqlm8l594nsrr8b1gcu64u.apps.googleusercontent.com"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Fabric and Crashlytics
        Fabric.with([Crashlytics.self])
        
        // Google Maps
        GMSServices.provideAPIKey(kGoogleMapsAPIKey)
        
        // Google Login
        GIDSignIn.sharedInstance().clientID = kGoogleSignInAPIKey
        GIDSignIn.sharedInstance().delegate = self

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
   func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
}

extension AppDelegate: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(#function) \(error.localizedDescription)")
        } else {
            print("\(#function) Google User Connected: \(user)")
            print("Google User token: \(user.userID)")
            
            let avatarURL = user.profile.imageURL(withDimension: 800)
            let currentUserProfile = Profile(authorizationMethod: .google, identifier: user.userID, name: user.profile.name, avatarURL: avatarURL)
            CredentialsStore.store.setUserProfile(currentUserProfile)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(#function) \(error.localizedDescription)")
        } else {
            print("\(#function) Google User Disconnected: \(user)")
        }
    }
}
