//
//  SessionModel.swift
//  WebSiteBlocker
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//

import Foundation
import FamilyControls

struct UserSession: Codable, Identifiable {
    let id: UUID
    var name: String
    var discouragedSelections: FamilyActivitySelection
    var startTime: Date
    var endTime: Date
    var listWebDomain: [String]
    var isActive: Bool

    
    init(name: String, discouragedSelections: FamilyActivitySelection, startTime: Date, endTime: Date, listWebDomain: [String], isActive: Bool = false) {
        self.id = UUID()
        self.name = name
        self.discouragedSelections = discouragedSelections
        self.startTime = startTime
        self.endTime = endTime
        self.listWebDomain = listWebDomain
        self.isActive = isActive

    }
}
