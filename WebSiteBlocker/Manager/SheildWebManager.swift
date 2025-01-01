//
//  SheildWebManager.swift
//  WebSiteBlocker
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//

import Foundation
import FamilyControls
import ManagedSettings

class SheildWebManager {
    
    private let store = ManagedSettingsStore()
    
    func startShielding(webDomain: [String]) {
        
        //let setWebDomain: Set<WebDomain> = [WebDomain(domain: "https://www.instagram.com/")]
        let setWebDomain: Set<WebDomain> = Set(webDomain.map { WebDomain(domain: $0) })

        // Set the blocked domains
        store.webContent.blockedByFilter = .specific(setWebDomain)
    }
  
    func clearStore() {
        store.clearAllSettings()
    }
    
    func saveSchedule() {

        let startTime = Calendar.current.dateComponents([.hour, .minute], from: Date() + 120)
        let endTime = Calendar.current.dateComponents([.hour, .minute], from: Date() + 1020)
        debugPrint(startTime)
        debugPrint(endTime)
        DeviceActivityManager.shared.handleStartDeviceActivityMonitoring(
            startTime: startTime,
            endTime: endTime
        )
   
        AppGroupManager.shared.saveFamilyActivitySelection(selection: .init(
            name: "Web Session",
            discouragedSelections: .init(),
            startTime: Date() + 10,
            endTime: Date() + 900,
            listWebDomain: ["www.instagram.com","www.google.com"]
        ))
    }
}


