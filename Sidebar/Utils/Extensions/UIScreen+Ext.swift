//
//  UIScreen+Ext.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import Foundation
import UIKit

extension UIScreen {
    static var screenSize: CGSize {
        guard let screenSize: CGSize = UIWindow.current?.screen.bounds.size else { return .zero }
        
        return screenSize
    }
}
