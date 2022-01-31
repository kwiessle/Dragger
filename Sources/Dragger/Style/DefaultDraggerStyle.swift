//
//  DefaultDraggerStyle.swift
//  
//
//  Created by Kiefer Wiessler on 29/01/2022.
//

import SwiftUI

struct DefaultDraggerStyle: DraggerStyle {
    
    var insets: CGFloat = .zero
    
    var thumbSize: CGSize = CGSize(width: 46, height: 46)
    
    var trackHeight: CGFloat = 50
    
    #if os(iOS)
    let bodyColor: Color = Color(UIColor.systemFill)
    let trackColor: Color = Color(UIColor.systemGray4)
    #elseif os(macOS)
    let bodyColor: Color = Color(NSColor.controlColor)
    let trackColor: Color = Color(NSColor.systemGray)
    #endif
    
    @State private var isHolding: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        (configuration.isComplete ? .green : bodyColor)
            .clipShape(Capsule())
    }
    
    func makeTrack(configuration: Configuration) -> some View {
        (configuration.isComplete ? .green : trackColor.opacity(configuration.fractionComplete))
            .clipShape(Capsule())
    }
    
    func makeThumb(configuration: Configuration) -> some View {
        Color.white
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
            
    }
    
}



