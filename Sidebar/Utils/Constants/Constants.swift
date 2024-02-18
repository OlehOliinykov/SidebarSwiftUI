//
//  Constants.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import Foundation
import SwiftUI

enum Constants {
    enum Sidebar {
        static let hundredPercent: CGFloat = 100
        static let sidebarThreshold: Double = 2.0
        static let sidebarLayerOpacity: Double = 0.6
        static let sidebarBackgroundColor: Color = .indigo
        static let sidebarScrollingAnimationDuration: Double = 0.2
        static let sidebarFastSwipeVelocityThreshold: CGFloat = 350
        static let sidebarEndScrollingAnimationDuration: Double = 0.3
        static let sidebarWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    }
}
