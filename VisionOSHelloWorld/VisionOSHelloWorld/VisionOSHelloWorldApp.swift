//
//  VisionOSHelloWorldApp.swift
//  VisionOSHelloWorld
//
//  Created by Ricardo on 2023/7/25.
//

import SwiftUI

@main
struct VisionOSHelloWorldApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
