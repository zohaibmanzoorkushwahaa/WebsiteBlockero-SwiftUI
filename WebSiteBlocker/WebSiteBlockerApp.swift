//
//  WebSiteBlockerApp.swift
//  WebSiteBlocker
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//

import SwiftUI
import UserNotifications

@main
struct WebSiteBlockerApp: App {
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentBlockerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }

}
