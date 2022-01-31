//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 29/01/2022.
//

import SwiftUI

struct DraggerStyleEnvironementKey: EnvironmentKey {
    static var defaultValue: AnyDraggerStyle = AnyDraggerStyle(DefaultDraggerStyle())
}

public extension EnvironmentValues {
    
    var draggerStyle: AnyDraggerStyle {
        get { self[DraggerStyleEnvironementKey.self] }
        set { self[DraggerStyleEnvironementKey.self] = newValue }
    }
    
}


