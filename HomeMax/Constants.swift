//
//  Constants.swift
//  HomeMax
//
//  Created by Ikmal Azman on 27/12/2021.
// 218380

import Foundation
import UIKit

struct AppTheme {
    static func clearDefaultNavigationBar(_ navBar : UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}

struct SeguesID {
    static let toARSceneVC = "goToARSceneViewController"
    static let toProductDetails = "goToProductDetailsViewController"
}

struct Device {
    static let bounds = UIScreen.main.bounds
    static let width = bounds.width
    static let height = bounds.height
}


extension UIColor {
    static let primaryDarkGreen = UIColor(hex: "218380")!
    static let secondaryLightGrey = UIColor(hex: "B1B1B1")!
}
