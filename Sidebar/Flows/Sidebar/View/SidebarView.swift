//
//  SidebarView.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import SwiftUI

struct SidebarView: View {
    @ObservedObject private var service: SidebarService
        
    init(with service: SidebarService) {
        self.service = service
    }
    
    var body: some View {
        sidebar
    }
    
    private var sidebar: some View {
        ZStack {
            sidebarShadowLayer
            sidebarComposition
        }
        .ignoresSafeArea(.all)
    }
    
    private var sidebarShadowLayer: some View {
        Color.black
            .opacity(service.shadowLayerOpacity)
            .onTapGesture {
                service.isSidebarOpen.toggle()
            }
    }
        
    private var sidebarComposition: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .center) {
                Constants.Sidebar.sidebarBackgroundColor
                
                sidebarBody
            }
            .frame(width: Constants.Sidebar.sidebarWidth)
            .offset(x: service.leftHandSideAnchorOffset)
            
            Spacer()
        }
    }
    
    private var sidebarBody: some View {
        Text("Sidebar body")
            .foregroundStyle(.white)
    }
}
