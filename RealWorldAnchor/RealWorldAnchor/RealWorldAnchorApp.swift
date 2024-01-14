//
//  RealWorldAnchorApp.swift
//  RealWorldAnchor
//
//  Created by Ricardo Chao on 2024/1/14.
//

import SwiftUI

@main
struct RealWorldAnchorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
