//
//  SwiftUIView.swift
//  
//
//  Created by Kiefer Wiessler on 29/01/2022.
//

import SwiftUI

//MARK: - A Type Erased Dragger Style

public struct AnyDraggerStyle: DraggerStyle {
    
    private var _makeBody: (Configuration) -> AnyView
    
    private var _makeTrack: (Configuration) -> AnyView
    
    private var _makeThumb: (Configuration) -> AnyView
   
    public let insets: CGFloat
    
    public let thumbSize: CGSize
    
    public let trackHeight: CGFloat
    
    
    public init<Style>(_ style: Style) where Style: DraggerStyle {
        self._makeBody = { AnyView(style.makeBody(configuration: $0)) }
        self._makeTrack = { AnyView(style.makeTrack(configuration: $0)) }
        self._makeThumb = { AnyView(style.makeThumb(configuration: $0)) }
        self.insets = style.insets
        self.thumbSize = style.thumbSize
        self.trackHeight = style.trackHeight
    }
    
    
    public func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
    
    public func makeTrack(configuration: Configuration) -> some View {
        _makeTrack(configuration)
    }
    
    public func makeThumb(configuration: Configuration) -> some View {
        _makeThumb(configuration)
    }
    
}
