//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 29/01/2022.
//

import SwiftUI

public protocol DraggerStyle {
    
    associatedtype Body: View
    
    associatedtype Track: View
    
    associatedtype Thumb: View
    
    typealias Configuration = DraggerConfiguration

    
    var insets: CGFloat { get }
    
    var thumbSize: CGSize { get }
    
    var trackHeight: CGFloat { get }
    
   
    @ViewBuilder func makeBody(configuration: Configuration) -> Body
    
    @ViewBuilder func makeTrack(configuration: Configuration) -> Track
    
    @ViewBuilder func makeThumb(configuration: Configuration) -> Thumb
    
}
