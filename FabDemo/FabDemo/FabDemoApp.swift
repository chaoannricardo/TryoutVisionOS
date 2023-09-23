//
//  FabDemoApp.swift
//  FabDemo
//
//  Created by Ricardo on 2023/8/23.
//

import SwiftUI

@main
struct FabDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
