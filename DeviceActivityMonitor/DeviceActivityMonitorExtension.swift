//
//  DeviceActivityMonitorExtension.swift
//  DeviceActivityMonitor
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//

import DeviceActivity
import UserNotifications
import ManagedSettings
import FamilyControls

// Optionally override any of the functions below.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    
    private let userDefaultsKey = "ScreenTimeSelection"
    
    let store = ManagedSettingsStore(named: .daily)
    
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        
        // Handle the start of the interval.
       let session = getSavedFamilyActivitySelection()
        
       scheduleNotification(with: "intervalDidStart \(session?.name ?? "Nil")")
        let webDomain = session?.listWebDomain ?? []
        let setWebDomain: Set<WebDomain> = Set(webDomain.map { WebDomain(domain: $0) })
        // Set the blocked domains
        store.webContent.blockedByFilter = .specific(setWebDomain)
    }
    
    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        
        // Handle the end of the interval.
        scheduleNotification(with: "intervalDidEnd ")
        
        let store = ManagedSettingsStore(named: .init(activity.rawValue))
        store.clearAllSettings()
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventDidReachThreshold(event, activity: activity)
        
        // Handle the event reaching its threshold.
        scheduleNotification(with: "eventDidReachThreshold ")
    }
    
    override func intervalWillStartWarning(for activity: DeviceActivityName) {
        super.intervalWillStartWarning(for: activity)
        
        // Handle the warning before the interval starts.
        scheduleNotification(with: "intervalWillStartWarning ")
    }
    
    override func intervalWillEndWarning(for activity: DeviceActivityName) {
        super.intervalWillEndWarning(for: activity)
        
        // Handle the warning before the interval ends.
        scheduleNotification(with: "intervalWillEndWarning ")
    }
    
    override func eventWillReachThresholdWarning(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        
        // Handle the warning before the event reaches its threshold.
        scheduleNotification(with: "eventWillReachThresholdWarning ")
    }
    
    //get saved family activity selection from UserDefault
    func getSavedFamilyActivitySelection() -> UserSession? {
        let defaults = UserDefaults(suiteName: "group.com.arhamsoft.zmk.WebSiteBlocker.sharedData")
        guard let data = defaults?.data(forKey: userDefaultsKey) else {
            return nil
        }
        var selectedApp: UserSession?
        let decoder = PropertyListDecoder()
        selectedApp = try? decoder.decode(UserSession.self, from: data)
        
        print("saved app updated: ", selectedApp?.discouragedSelections.applicationTokens.count ?? 0,"saved selected app updated: ", selectedApp?.discouragedSelections.categoryTokens.count ?? "0")
        return selectedApp
    }
    
    func scheduleNotification(with title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Notification content."
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
