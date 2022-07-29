//
//  User Defaults.swift
//  Recollect
//
//  Created by student on 2022-07-23.
//

// User Defaults 
import Foundation

extension UserDefaults {
    private enum UserDefaultKeys: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
}


