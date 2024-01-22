//
//  ContentView.swift
//  PhysicsInteraction
//
//  Created by Ricardo Chao on 2024/1/21.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    let modelPyhysics = PhysicsInteractionModel()

    var body: some View {
        
        
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    
                    await modelPyhysics.load3DModels()
                    
                    scene.addChild(modelPyhysics.modelEntity)
                    scene.addChild(modelPyhysics.entityLoaded)
    
                    content.add(scene)
                }
                
                
            } update: { content in
             
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
               
            })


        }
        
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
