//
//  AppDelegate.swift
//  WebSiteBlocker
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//


import UIKit
import FamilyControls
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - FamilyControls
    let authorizationCenter = AuthorizationCenter.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        auth()
        registerLocal()
        return true
    }
    
    func auth() {
        Task {
            do {
                try await authorizationCenter.requestAuthorization(for: .individual)
            } catch {
                print("Failed to enroll Aniyah with error: \(error)")
            }
        }
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .alert]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
}

class NotificationDelegate: NSObject , UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Notification tapped`")
        //Do what you need to do here once the app is opened by tapping on the notification.

        completionHandler()
    }
}
