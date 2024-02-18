//
//  ImagesView.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import SwiftUI

struct GalleryView: View {
    @ObservedObject private var service: SidebarService
    
    init(with service: SidebarService) {
        self.service = service        
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                images
                    .background(scrollDetection)
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        service.startScrollingDetector.send(value)
                        service.endScrollingDetector.send(value)
                    }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        service.isSidebarOpen.toggle()
                    } label: {
                        Image(systemName: Constants.ImageNames.toggleSidebarImage)
                            .renderingMode(.original)
                            .foregroundStyle(.indigo)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Constants.Navigation.galleryNavigationTitle)
            .coordinateSpace(name: Constants.CoordinateSpaces.scrollCoordinateSpace)
        }
    }
    
    private var images: some View {
        ForEach(Constants.DataSource.imagesRange, id: \.self) { _ in
            AsyncImage(url: URL(string: Constants.URLs.imagesSourceURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: Constants.CornerRadius.imageCornerRadius)
                        .fill(.ultraThinMaterial)
                    ProgressView()
                }
                
            }
            .frame(height: Constants.Frames.defaultImageHeight)
            .aspectRatio(Constants.AspectRation.imageAspectRatio, contentMode: .fill)
            .cornerRadius(Constants.CornerRadius.imageCornerRadius)
            .padding()
        }
    }
    
    private var scrollDetection: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self,
                                   value: geometry.frame(in: .named(Constants.CoordinateSpaces.scrollCoordinateSpace)).origin.y)
        }
    }
}

fileprivate extension Constants {
    enum CoordinateSpaces {
        static let scrollCoordinateSpace: String = "ImagesListScrollView"
    }
    
    enum AspectRation {
        static let imageAspectRatio: CGFloat = (3 / 2)
    }
    
    enum DataSource {
        static let imagesRange: Range<Int> = (.zero..<8)
        static let imagesCount: CGFloat = 8
    }
    
    enum ImageNames {
        static let toggleSidebarImage: String = "line.3.horizontal.circle.fill"
    }
    
    enum Navigation {
        static let galleryNavigationTitle: String = "Gallery"
    }
        
    enum CornerRadius {
        static let imageCornerRadius: CGFloat = 32
    }
    
    enum Frames {
        static let defaultImageHeight: Double = UIScreen.screenSize.height * 0.425
    }
    
    enum URLs {
        static let imagesSourceURL: String = "https://picsum.photos/600"
    }
}
