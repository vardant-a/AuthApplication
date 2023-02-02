//
//  Appearance.swift
//  AuthApplication
//
//  Created by Aleksei on 02.02.2023.
//

import UIKit

extension AppSettings {
    
    enum Appearance: Int {
        case auto
        case light
        case dark
    }
}

extension AppSettings.Appearance {
    
    func getUIstyle() -> UIUserInterfaceStyle {
        switch self {
        case .auto:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    func setupAppearance(_ view: UIView, tag: Int) {
        AppSettings.shared.appearance = AppSettings.Appearance(
            rawValue: tag) ?? .auto
        view.window?.overrideUserInterfaceStyle = AppSettings.shared.appearance.getUIstyle()

    }
}
