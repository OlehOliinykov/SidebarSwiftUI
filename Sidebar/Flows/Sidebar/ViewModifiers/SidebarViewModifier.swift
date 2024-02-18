//
//  SidebarViewModifier.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import Foundation
import SwiftUI

struct SidebarViewModifier: ViewModifier {
    @ObservedObject private var service: SidebarService
    
    private var sidebarDragGesture: some Gesture {
        DragGesture()
            .onChanged { changes in
                let widthTranslation = changes.translation.width
                let heightTranslation = changes.translation.height
                
                if service.isSidebarEnable {
                    let calculationMethod = service.isSidebarOpen ? Constants.Sidebar.sidebarWidth + widthTranslation : widthTranslation
                    
                    withAnimation(.linear(duration: Constants.Sidebar.sidebarScrollingAnimationDuration)) {
                        guard service.isHorizontalScrollDominate(width: widthTranslation, height: heightTranslation) else { return service.sidebarThresholdChecker() }
                        
                        guard service.percentDistanceProgress <= Constants.Sidebar.hundredPercent,
                              calculationMethod <= Constants.Sidebar.sidebarWidth else { return service.sidebarOffset = Constants.Sidebar.sidebarWidth }
                        
                        service.isSidebarScrolling.send(true)
                        
                        service.sidebarOffset = calculationMethod
                        service.shadowLayerOpacity = (Constants.Sidebar.sidebarLayerOpacity * service.percentDistanceProgress) / Constants.Sidebar.hundredPercent
                    }
                }
            }
            .onEnded { ended in
                let leftFastSwipe: PartialRangeThrough<CGFloat> = ...(-Constants.Sidebar.sidebarFastSwipeVelocityThreshold)
                let rightFastSwipe: PartialRangeFrom<CGFloat> = Constants.Sidebar.sidebarFastSwipeVelocityThreshold...
                
                withAnimation(.easeInOut(duration: Constants.Sidebar.sidebarEndScrollingAnimationDuration)) {
                    service.isSidebarScrolling.send(false)
                    
                    switch ended.velocity.width {
                    case (rightFastSwipe):
                        service.openSidebar()
                    case (leftFastSwipe):
                        service.closeSidebar()
                    default:
                        service.sidebarThresholdChecker()
                    }
                }
            }            
    }
    
    init(with service: SidebarService) {        
        self.service = service
    }
    
    func body(content: Content) -> some View {
        content
            .gesture(sidebarDragGesture)
            .onChange(of: service.isSidebarOpen) { newValue in
                withAnimation(.easeInOut(duration: Constants.Sidebar.sidebarEndScrollingAnimationDuration)) {
                    if newValue {
                        service.openSidebar()
                    } else {
                        service.closeSidebar()
                    }
                }
            }
    }
}
