//
//  ContentView.swift
//  EntityTryOut
//
//  Created by Ricardo on 2023/10/21.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @Environment(
        \.openImmersiveSpace
    ) var openImmersiveSpace
    @Environment(
        \.dismissImmersiveSpace
    ) var dismissImmersiveSpace
    
    @State private var sphere: Entity?

    @State private var subscription: EventSubscription?
    
    var body: some View {
        VStack {
            RealityView { content, attachments  in
                
                if let scene = try? await Entity( named: "Scene", in: realityKitContentBundle)
                {
                    
                    let entity = attachments.entity(for: "entity") ?? Entity()
                    let tooltip0 = attachments.entity(for: "tooltip0") ?? Entity()

                    print(scene)
                    print(attachments)
                    
                    
//                    content.add(entity)
                    content.add(tooltip0)
                    content.add(scene)
                    
                    // collision event subscription
                    sphere = content.entities.first?.findEntity(named: "Sphere")
                    subscription = content.subscribe(
                        to: CollisionEvents.Began.self,
                        on: sphere
                    ) { collisionEvent in
                        print(
                            "💥 Collision between \(collisionEvent.entityA.name) and \(collisionEvent.entityB.name)"
                        )
                    }
                    
                }

                
            } update: { content, attachments in
                
                let sphere = content.entities.first?.findEntity(named: "Sphere")
                let clipboard_0 = content.entities.first?.findEntity(named: "Clipboard_0")
                
                let tooltip0 = attachments.entity(for: "tooltip0")
                let entity = attachments.entity(for: "entity")
                
                // set position
                clipboard_0?.setPosition(
                    SIMD3<Float>(x: -0.2, y: -0, z: 0.2),
                    relativeTo: sphere
                ) 
                
//                tooltip0?.move(to: Transform(), relativeTo: sphere, duration: 5)
                
                tooltip0?.setPosition(
                    SIMD3<Float>(x: -0, y: -0, z: 0.1),
                    relativeTo: sphere
                )
                
  
//                tooltip0?.setPosition(
//                    SIMD3<Float>(x: 0.8, y: 0, z: 0.2),
//                    relativeTo: sphere
//                )
   
//                entity?.setPosition(
//                    SIMD3<Float>(x: -0.8, y: -0.5, z: -0.4),
//                    relativeTo: sphere
//                )
                
                
                // move to a location
                //                clipboard_0?.move(
                //                    to: Transform(
                //                        scale: SIMD3<Float>(x: 1, y: 1, z: 1)
                //                    ),
                //                    relativeTo: sphere,
                //                    duration: 4)
                
                // rotate 180 degree
                //                clipboard_0?.move(to: .init(roll: .pi),
                //                                 relativeTo: clipboard_0,
                //                                duration: 4.0, timingFunction: .linear)
                //                
                
            } attachments: {
                //https://developer.apple.com/forums/thread/736588
                
                Attachment(id: "entity") {
                    LearnMoreView(name: "Phoenix Lake",
                                  description: "Lake · Northern California")
                   }
                
                Attachment(id: "tooltip0") {
                    ToolTipView()
                }
                
                
            }
            .gesture(
                
                DragGesture()
                    .targetedToEntity(
                        sphere ?? Entity()
                    )
                    .onChanged {
                        value in
                        guard let sphere,
                              let parent = sphere.parent else {
                            return
                        }
                        
                        sphere.position = value.convert(
                            value.location3D,
                            from: .local,
                            to: parent
                        )
                    }
                
            )
        }
    }
}

#Preview(
    windowStyle: .volumetric
) {
    ContentView()
}
