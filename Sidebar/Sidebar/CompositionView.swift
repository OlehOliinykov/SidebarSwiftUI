//
//  ContentView.swift
//  Sidebar
//
//  Created by Oleh Oliinykov on 13.02.2024.
//

import SwiftUI

struct CompositionView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    CompositionView()
}
