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
        ScrollView {
            images
            .background(scrollDetection)
            .onPreferenceChange(ViewOffsetKey.self) { value in
                startScrollingDetector.send(value)
                endScrollingDetector.send(value)
            }
        }
        .coordinateSpace(name: "scroll")
    }
    
    private var images: some View {
        ForEach(0..<8) { _ in
            AsyncImage(url: URL(string: "https://picsum.photos/600")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
            } placeholder: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.6))
                        .frame(height: 240)
                    ProgressView()
                }
            }
            .aspectRatio(3 / 2, contentMode: .fill)
            .cornerRadius(16)
            .padding()
        }
    }
    
    private var scrollDetection: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: ViewOffsetKey.self,
                                   value: -geometry.frame(in: .named("scroll")).origin.y)
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
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .dropFirst()
            .sink { _ in
                print("End scrolling")
            }
            .store(in: &cancellables)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    ImagesView()
}
