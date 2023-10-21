//
//  EntityTryOutApp.swift
//  EntityTryOut
//
//  Created by Ricardo on 2023/10/21.
//

import SwiftUI

@main
struct EntityTryOutApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
