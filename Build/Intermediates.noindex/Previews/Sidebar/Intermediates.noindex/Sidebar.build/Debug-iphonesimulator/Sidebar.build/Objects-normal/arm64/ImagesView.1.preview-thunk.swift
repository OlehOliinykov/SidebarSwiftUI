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

extension ViewOffsetKey {
    @_dynamicReplacement(for: reduce(value:nextValue:)) private static func __preview__reduce(value: inout Value, nextValue: () -> Value) {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 88)
        value += nextValue()
    
#sourceLocation()
    }
}

extension ImagesView {
    @_dynamicReplacement(for: setupEndScrollingObserver()) private mutating func __preview__setupEndScrollingObserver() {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 72)
        endScrollingDetector
            .debounce(for: .milliseconds(__designTimeInteger("#5495.[2].[8].[0].modifier[0].arg[0].value.arg[0].value", fallback: 100)), scheduler: RunLoop.main)
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
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 63)
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
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 56)
        GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self,
                                   value: -geometry.frame(in: .named("scroll")).origin.y)
        }
    
#sourceLocation()
    }
}

extension ImagesView {
    @_dynamicReplacement(for: images) private var __preview__images: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 35)
        ForEach(__designTimeInteger("#5495.[2].[5].property.[0].[0].arg[0].value.[0]", fallback: 0)..<__designTimeInteger("#5495.[2].[5].property.[0].[0].arg[0].value.[1]", fallback: 8)) { _ in
            AsyncImage(url: URL(string: __designTimeString("#5495.[2].[5].property.[0].[0].arg[1].value.[0].arg[0].value.arg[0].value", fallback: "https://picsum.photos/600"))) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: __designTimeInteger("#5495.[2].[5].property.[0].[0].arg[1].value.[0].arg[1].value.[0].modifier[2].arg[0].value", fallback: 240))
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: __designTimeInteger("#5495.[2].[5].property.[0].[0].arg[1].value.[0].arg[2].value.[0].arg[0].value.[0].arg[0].value", fallback: 12))
                        .fill(.gray.opacity(__designTimeFloat("#5495.[2].[5].property.[0].[0].arg[1].value.[0].arg[2].value.[0].arg[0].value.[0].modifier[0].arg[0].value.modifier[0].arg[0].value", fallback: 0.6)))
                        .frame(height: __designTimeInteger("#5495.[2].[5].property.[0].[0].arg[1].value.[0].arg[2].value.[0].arg[0].value.[0].modifier[1].arg[0].value", fallback: 240))
                    ProgressView()
                }
            }
            .aspectRatio(__designTimeInteger("#5495.[2].[5].property.[0].[0].arg[1].value.[0].modifier[0].arg[0].value.[0]", fallback: 3) / __designTimeInteger("#5495.[2].[5].property.[0].[0].arg[1].value.[0].modifier[0].arg[0].value.[1]", fallback: 2), contentMode: .fill)
            .cornerRadius(__designTimeInteger("#5495.[2].[5].property.[0].[0].arg[1].value.[0].modifier[1].arg[0].value", fallback: 16))
            .padding()
        }
    
#sourceLocation()
    }
}

extension ImagesView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Sidebar/ImagesView.swift", line: 23)
        ScrollView {
            images
            .background(scrollDetection)
            .onPreferenceChange(ViewOffsetKey.self) { value in
                startScrollingDetector.send(value)
                endScrollingDetector.send(value)
            }
        }
        .coordinateSpace(name: __designTimeString("#5495.[2].[4].property.[0].[0].modifier[0].arg[0].value", fallback: "scroll"))
    
#sourceLocation()
    }
}

import struct Sidebar.ImagesView
import struct Sidebar.ViewOffsetKey
#Preview {
    ImagesView()
}

// Support for back-deployment.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, visionOS 1.0, watchOS 6.0, *)
struct RegistryCompatibilityProvider_line_107: SwiftUI.PreviewProvider {
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




