@_private(sourceFile: "CompositionView.swift") import Sidebar
import func SwiftUI.__designTimeBoolean
import func SwiftUI.__designTimeInteger
import protocol SwiftUI.PreviewProvider
import func SwiftUI.__designTimeString
import func SwiftUI.__designTimeFloat
import struct SwiftUI.EmptyView
import protocol SwiftUI.View
import SwiftUI

extension CompositionView {
    @_dynamicReplacement(for: composition) private var __preview__composition: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Flows/Composition/CompositionView.swift", line: 18)
        ZStack {
            GalleryView(with: sidebarService)
            SidebarView(with: sidebarService)
        }
        .modifier(SidebarViewModifier(with: sidebarService))
    
#sourceLocation()
    }
}

extension CompositionView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/olehcartelll/Documents/petProjects/Sidebar/Sidebar/Flows/Composition/CompositionView.swift", line: 14)
        composition
    
#sourceLocation()
    }
}

import struct Sidebar.CompositionView
#Preview {
    CompositionView()
}

// Support for back-deployment.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, visionOS 1.0, watchOS 6.0, *)
struct RegistryCompatibilityProvider_line_34: SwiftUI.PreviewProvider {
    static var previews: some SwiftUI.View {
        #if os(iOS)
        let __makePreview: () -> any SwiftUI.View = {
            CompositionView()
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




