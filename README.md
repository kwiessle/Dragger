# Dragger

```swift
import SwiftUI
import Dragger

struct ContentView: View {
    
    @State var isComplete: Bool = false
    
    var body: some View {
        Dragger(isComplete: $isComplete)
    }
    
}

