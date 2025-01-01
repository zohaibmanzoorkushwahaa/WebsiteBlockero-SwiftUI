//
//  DeviceActivityManager.swift
//  WebSiteBlocker
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//

import Foundation
import DeviceActivity

class DeviceActivityManager: ObservableObject {
    
    static let shared = DeviceActivityManager()
    
    private init() {}
    
    let deviceActivityCenter = DeviceActivityCenter()
    
    func handleStartDeviceActivityMonitoring(
        startTime: DateComponents,
        endTime: DateComponents,
        deviceActivityName: DeviceActivityName = .daily,
        warningTime: DateComponents = DateComponents(minute: 2)
    ) {
        let schedule: DeviceActivitySchedule
        
        if deviceActivityName == .daily {
            schedule = DeviceActivitySchedule(
                intervalStart: startTime,
                intervalEnd: endTime,
                repeats: true,
                warningTime: warningTime
            )
            do {
                try deviceActivityCenter.startMonitoring(deviceActivityName, during: schedule)

            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }
    
    // MARK: - Device Activity
    func handleStopDeviceActivityMonitoring() {
        deviceActivityCenter.stopMonitoring()
    }
}

// MARK: - Schedule Name List
extension DeviceActivityName {
    static let daily = Self("daily")
}

