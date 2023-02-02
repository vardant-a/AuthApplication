//
//  AppSettings.swift
//  AuthApplication
//
//  Created by Aleksei on 02.02.2023.
//

import Foundation

class AppSettings {
    static let shared = AppSettings()
    private let defaults = UserDefaults.standard
    
    var appearance: Appearance {
        get {
            Appearance(rawValue: defaults.integer(forKey: AppSettingsKey.appearance.rawValue)) ?? .auto
        } set {
            defaults.set(newValue.rawValue, forKey: AppSettingsKey.appearance.rawValue)
        }
    }
    
    var language: Int {
        get {
            defaults.integer(forKey: AppSettingsKey.language.rawValue)
        } set {
            defaults.set(newValue, forKey: AppSettingsKey.language.rawValue)
        }
    }
    
    private init() {}
}

extension AppSettings {
    
    enum AppSettingsKey: String {
        case appearance = "Appearance"
        case language = "Language"
    }
}
