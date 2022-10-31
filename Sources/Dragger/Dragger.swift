//
//  Dragger.swift
//
//
//  Created by Kiefer Wiessler on 29/01/2022.
//

import SwiftUI

public struct Dragger: View {
    
    
    @State private var offset: CGFloat = .zero
    
    @State private var fractionComplete: CGFloat = 0
    
    @State private var isHoldingThumb: Bool = false
    
    @Binding var isComplete: Bool {
        didSet {
            #if os(iOS)
                isComplete != oldValue ? UIImpactFeedbackGenerator(style: .medium).impactOccurred() : ()
            #endif
        }
    }
    
    @Environment(\.draggerStyle) private var style
    
    
    private var configuration: DraggerConfiguration {
        DraggerConfiguration(
            isComplete: isComplete,
            fractionComplete: fractionComplete,
            isHoldingThumb: isHoldingThumb
        )
    }
    
    private var thumbVerticalPadding: CGFloat {
        (style.trackHeight - style.thumbSize.height) / 2
    }
    
    private var thumbHorizontalPadding: CGFloat {
        style.trackHeight > style.thumbSize.height ? (style.trackHeight - style.thumbSize.height) / 2 : .zero
    }
    
    public var body: some View {
        GeometryReader { proxy in
            style.makeTrack(configuration: configuration)
                .frame(
                    width: offset + style.thumbSize.width + 2 * thumbHorizontalPadding,
                    height: style.trackHeight
                )
            style.makeThumb(configuration: configuration)
                .frame(
                    width: style.thumbSize.width,
                    height: style.thumbSize.height
                )
                .offset(
                    x: offset + thumbHorizontalPadding,
                    y: thumbVerticalPadding
                )
                .onAppear(perform: {
                    if isComplete {
                        offset = proxy.size.width - style.thumbSize.width - 2 * thumbHorizontalPadding
                        fractionComplete = 1
                    }
                })
                .onChange(of: proxy.size, perform: { newValue in
                    if isComplete {
                       offset = proxy.size.width - style.thumbSize.width - 2 * thumbHorizontalPadding
                    }
                })
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            let maxOffset = proxy.size.width - style.thumbSize.width - 2 * thumbHorizontalPadding
                            let location = value.location.x - style.thumbSize.width / 2
                            isHoldingThumb = true
                            offset = max(.zero, min(location, maxOffset))
                            isComplete = offset == maxOffset
                            fractionComplete = offset / maxOffset
                        })
                        .onEnded({ value in
                            isHoldingThumb = false
                            if isComplete {
                            
                            } else {
                                withAnimation(.spring()) {
                                
                                    fractionComplete = .zero
                                    offset = .zero
                                }
                            }
                        })
                        
                )

            
        }
        .frame(
            minWidth: 2 * style.thumbSize.width + thumbVerticalPadding,
            maxWidth: .infinity,
            minHeight: style.trackHeight,
            maxHeight: style.trackHeight
        )
        .padding(style.insets)
        .background(
            style.makeBody(configuration: configuration)
        )
    }
    
    public init(isComplete: Binding<Bool>) {
        self._isComplete = isComplete
    }
    
}

extension View {
    public func draggerStyle<Style: DraggerStyle>(_ style: Style) -> some View {
        environment(\.draggerStyle, AnyDraggerStyle(style))
    }
}
