//
//  ViewOffsetKey.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import Foundation
import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
