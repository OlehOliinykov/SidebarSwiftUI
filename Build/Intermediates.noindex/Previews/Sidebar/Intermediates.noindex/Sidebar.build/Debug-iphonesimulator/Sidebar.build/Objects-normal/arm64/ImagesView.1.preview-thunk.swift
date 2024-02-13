@_private(sourceFile: "ImagesView.swift") import Sidebar
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import Combine
import SwiftUI

extension ImagesView {
    @_dynamicReplacement(for: setupEndScrollingObserver()) private mutating func __preview__setupEndScrollingObserver() {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 75)
        endScrollingDetector
            .debounce(for: .milliseconds(Constants.Delays.debounceMilliseconds), scheduler: RunLoop.main)
            .dropFirst()
            .sink { _ in
                print(__designTimeString("#5495.[2].[8].[0].modifier[2].arg[0].value.[0].arg[0].value", fallback: "End scrolling"))
            }
            .store(in: &cancellables)
    
#sourceLocation()
    }
}

extension ImagesView {
    @_dynamicReplacement(for: setupStartScrollingObserver()) private mutating func __preview__setupStartScrollingObserver() {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 66)
        startScrollingDetector
            .dropFirst()
            .sink { _ in
                print(__designTimeString("#5495.[2].[7].[0].modifier[1].arg[0].value.[0].arg[0].value", fallback: "Scroll"))
            }
            .store(in: &cancellables)
    
#sourceLocation()
    }
}

extension ImagesView {
    @_dynamicReplacement(for: scrollDetection) private var __preview__scrollDetection: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 59)
        GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self,
                                   value: -geometry.frame(in: .named(Constants.CoordinateSpaces.scrollCoordinateSpace)).origin.y)
        }
    
#sourceLocation()
    }
}

extension ImagesView {
    @_dynamicReplacement(for: images) private var __preview__images: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 38)
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
    
#sourceLocation()
    }
}

extension ImagesView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 23)
        NavigationView {
            ScrollView(.vertical, showsIndicators: __designTimeBoolean("#5495.[2].[4].property.[0].[0].arg[0].value.[0].arg[1].value", fallback: false)) {
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
    
#sourceLocation()
    }
}

import struct Sidebar.ImagesView
#Preview {
    ImagesView()
}

// Support for back-deployment.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, visionOS 1.0, watchOS 6.0, *)
struct RegistryCompatibilityProvider_line_100: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        #if os(iOS)
        let __makePreview: () -> any SwiftUI.View = {
            ImagesView()
        }
        SwiftUI.VStack {
            SwiftUI.AnyView(__makePreview())
        }
        #else
        // The preview is not available.
        SwiftUI.EmptyView()
        #endif
    }
}




