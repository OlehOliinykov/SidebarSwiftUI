//
//  SidebarService.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import Foundation
import Combine

final class SidebarService: ObservableObject {
    let startScrollingDetector: PassthroughSubject<CGFloat, Never> = PassthroughSubject<CGFloat, Never>()
    let endScrollingDetector: PassthroughSubject<CGFloat, Never> = PassthroughSubject<CGFloat, Never>()
    let isSidebarScrolling: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
    
    @Published var isSidebarEnable: Bool = true
    @Published var isScrollEnable: Bool = true
    
    @Published var isSidebarOpen: Bool = false
    @Published var sidebarOffset: CGFloat = .zero
    @Published var shadowLayerOpacity: CGFloat = .zero
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private var sidebarThreshold: Double {
        let threshold: Double = Constants.Sidebar.sidebarWidth / Constants.Sidebar.sidebarThreshold
        
        return threshold
    }
    
    var percentDistanceProgress: Double {
        let progress: Double = (sidebarOffset * Constants.Sidebar.hundredPercent) / Constants.Sidebar.sidebarWidth
        
        return progress
    }
    
    var leftHandSideAnchorOffset: CGFloat {
        let offset: CGFloat = -Constants.Sidebar.sidebarWidth + sidebarOffset
        
        return offset
    }
    
    init() {
        setupStartScrollingObserver()
        setupEndScrollingObserver()
        sidebarScrollObserver()
    }
    
    func openSidebar() {
        isSidebarOpen = true
        sidebarOffset = Constants.Sidebar.sidebarWidth
        shadowLayerOpacity = Constants.Sidebar.sidebarLayerOpacity
    }
    
    func closeSidebar() {
        isSidebarOpen = false
        sidebarOffset = .zero
        shadowLayerOpacity = .zero
    }
    
    func sidebarThresholdChecker() {
        if sidebarOffset > sidebarThreshold {
            openSidebar()
        } else {
            closeSidebar()
        }
    }
    
    private func setupStartScrollingObserver() {
        startScrollingDetector
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                if self.isSidebarEnable {
                    self.isSidebarEnable = false
                    print("Start scroll")
                }
            }
            .store(in: &cancellables)
    }
    
    private func setupEndScrollingObserver() {
        endScrollingDetector
            .debounce(for: .milliseconds(Constants.Delays.debounceMilliseconds), scheduler: DispatchQueue.main)
            .dropFirst()
            .sink { [weak self] _ in
                guard let self else { return }
                if !self.isSidebarEnable {
                    self.isSidebarEnable = true
                    print("End scroll")
                }
            }
            .store(in: &cancellables)
    }
    
    private func sidebarScrollObserver() {
        isSidebarScrolling
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                if value != self?.isScrollEnable {
                    self?.isScrollEnable = value
                    print(value == true ? "Sidebar scroll" : "sidebar end scroll")
                }
            }
            .store(in: &cancellables)
    }
    
    func isHorizontalScrollDominate(width: CGFloat, height: CGFloat) -> Bool {
        let isHorizontalDominate: Bool = abs(width) > abs(height * 2)
        
        return sidebarOffset != .zero ? true : isHorizontalDominate
    }
}

fileprivate extension Constants {
    enum Delays {
        static let debounceMilliseconds: Int = 100
    }
}
