//
//  ContentView.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import SwiftUI

struct CompositionView: View {
    @StateObject private var sidebarService: SidebarService = SidebarService()
            
    var body: some View {
        composition
    }
    
    private var composition: some View {
        ZStack {
            GalleryView(with: sidebarService)
            SidebarView(with: sidebarService)
        }
        .modifier(SidebarViewModifier(with: sidebarService))
    }
}

#Preview {
    CompositionView()
}
