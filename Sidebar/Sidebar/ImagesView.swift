//
//  ImagesView.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import SwiftUI
import Combine

struct ImagesView: View {
    private let startScrollingDetector: CurrentValueSubject<CGFloat, Never> = CurrentValueSubject<CGFloat, Never>(.zero)
    private let endScrollingDetector: CurrentValueSubject<CGFloat, Never> = CurrentValueSubject<CGFloat, Never>(.zero)
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()

    init() {
        setupStartScrollingObserver()
        setupEndScrollingObserver()
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                images
                    .background(scrollDetection)
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        startScrollingDetector.send(value)
                        endScrollingDetector.send(value)
                    }
            }
            .coordinateSpace(name: Constants.CoordinateSpaces.scrollCoordinateSpace)
            .navigationTitle(Constants.Navigation.galleryNavigationTitle)
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
            .frame(height: UIScreen.screenSize.height * Constants.Frames.defaultImageHeightMultiplier)
            .aspectRatio(Constants.AspectRation.imageAspectRatio, contentMode: .fill)
            .cornerRadius(Constants.CornerRadius.imageCornerRadius)
            .padding()
        }
    }
    
    private var scrollDetection: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self,
                                   value: -geometry.frame(in: .named(Constants.CoordinateSpaces.scrollCoordinateSpace)).origin.y)
        }
    }
    
    private mutating func setupStartScrollingObserver() {
        startScrollingDetector
            .dropFirst()
            .sink { _ in
                print("Scroll")
            }
            .store(in: &cancellables)
    }
    
    private mutating func setupEndScrollingObserver() {
        endScrollingDetector
            .debounce(for: .milliseconds(Constants.Delays.debounceMilliseconds), scheduler: RunLoop.main)
            .dropFirst()
            .sink { _ in
                print("End scrolling")
            }
            .store(in: &cancellables)
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
    
    enum Navigation {
        static let galleryNavigationTitle: String = "Gallery"
    }
        
    enum CornerRadius {
        static let imageCornerRadius: CGFloat = 32
    }
    
    enum Delays {
        static let debounceMilliseconds: Int = 100
    }
    
    enum Frames {
        static let defaultImageHeightMultiplier: Double = 0.425
    }
    
    enum URLs {
        static let imagesSourceURL: String = "https://picsum.photos/600"
    }
}

#Preview {
    ImagesView()
}
