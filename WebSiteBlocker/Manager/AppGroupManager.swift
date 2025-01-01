//
//  AppGroupManager.swift
//  WebSiteBlocker
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//

import Foundation
import FamilyControls


class AppGroupManager {
    
    static let shared = AppGroupManager()
    
    private init() {}
    // Used to encode codable to UserDefaults
    private let encoder = PropertyListEncoder()

    // Used to decode codable from UserDefaults
    private let decoder = PropertyListDecoder()

    private let userDefaultsKey = "ScreenTimeSelection"
    
    func saveFamilyActivitySelection(selection: UserSession) {
        print("selected app updated: ", selection.discouragedSelections.applicationTokens.count," category: ", selection.discouragedSelections.categoryTokens.count)
          let defaults = UserDefaults(suiteName: "group.com.arhamsoft.zmk.WebSiteBlocker.sharedData")

        do {
            defaults?.set(
                
                try encoder.encode(selection),
                forKey: userDefaultsKey
                
            )
            
        } catch (let error) {
            debugPrint(error.localizedDescription)
        }
          
          //check is data saved to user defaults
        let session = getSavedFamilyActivitySelection()
        debugPrint(session?.listWebDomain.count)
      }
      
      //get saved family activity selection from UserDefault
      func getSavedFamilyActivitySelection() -> UserSession? {
          let defaults = UserDefaults(suiteName: "group.com.arhamsoft.zmk.WebSiteBlocker.sharedData")
          guard let data = defaults?.data(forKey: userDefaultsKey) else {
              return nil
          }
          var selectedApp: UserSession?
          let decoder = PropertyListDecoder()
          do {
              selectedApp = try decoder.decode(UserSession.self, from: data)
              
          } catch (let error) {
              debugPrint(error.localizedDescription)
          }
     
          
          print("saved app updated: ", selectedApp?.discouragedSelections.applicationTokens.count ?? 0,"saved selected app updated: ", selectedApp?.discouragedSelections.categoryTokens.count ?? "0")
          return selectedApp
      }
}
