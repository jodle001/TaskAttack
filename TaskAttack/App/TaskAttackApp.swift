//
//  TaskAttackApp.swift
//  TaskAttack
//
//  Created by Jacob Odle on 9/16/21.
//

import SwiftUI
import Firebase
import FirebaseAuth


@main
struct TaskAttackApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
     
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        // Firebase anonymous sign in
        Auth.auth().signInAnonymously()
        
        return true
    }
}
