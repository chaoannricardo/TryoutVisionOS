//
//  PhysicsInteractionApp.swift
//  PhysicsInteraction
//
//  Created by Ricardo Chao on 2024/1/21.
//

import SwiftUI

@main
struct PhysicsInteractionApp: App {
    var body: some Scene {
        
//        WindowGroup {
//            ContentView()
//        }.windowStyle(.volumetric)
        
        ImmersiveSpace {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
