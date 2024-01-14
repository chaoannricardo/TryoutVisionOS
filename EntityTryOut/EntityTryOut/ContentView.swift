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
                    
//                    let entity = attachments.entity(for: "entity") ?? Entity()
                    let tooltip0 = attachments.entity(for: "tooltip0") ?? Entity()
//                    let tooltip1 = attachments.entity(for: "tooltip1") ?? Entity()

                    // add entity into scene
//                    content.add(entity)
                    content.add(tooltip0)
                    
//                    content.add(tooltip1)
                    content.add(scene)
                    
                    // collision event subscription
                    // https://lickability.com/blog/detecting-collisions-with-realitykit-in-visionos/
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
                
                // scene entity
                let sphere = content.entities.first?.findEntity(named: "Sphere")
                let clipboard_0 = content.entities.first?.findEntity(named: "Clipboard_0")
                
                // attachment entity
//                let entity = attachments.entity(for: "entity")
                let tooltip0 = attachments.entity(for: "tooltip0")
//                let tooltip1 = attachments.entity(for: "tooltip1")
                
                
                // set position
                clipboard_0?.setPosition(
                    SIMD3<Float>(x: -0.2, y: -0, z: 0.2),
                    relativeTo: sphere
                )
                
//                tooltip1?.setPosition(SIMD3<Float>(x: 0, y: 0, z: 0),
//                                      relativeTo: sphere)
                
//                tooltip0?.move(to: Transform(), relativeTo: sphere, duration: 5)
                
                tooltip0?.setPosition(
                    SIMD3<Float>(x: 0, y: 0.4, z: 0.5),
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
                
                //https://stackoverflow.com/questions/76796001/how-to-rotate-a-modelentity-in-visionos
                // rotate 180 degree
                //                clipboard_0?.move(to: .init(roll: .pi),
                //                                 relativeTo: clipboard_0,
                //                                duration: 4.0, timingFunction: .linear)
                //        
                
                //anchoring
                //https://stackoverflow.com/questions/76561090/how-can-a-model-be-anchored-above-the-users-head-in-visionos
                
            } attachments: {
                //https://developer.apple.com/forums/thread/736588
                
                Attachment(id: "entity") {
                    LearnMoreView(name: "Phoenix Lake",
                    description: "Lake · Northern California")
                   }
                
                Attachment(id: "tooltip0") {
                    ToolTipView(textContent: "123456")
                }
                
//                Attachment(id: "tooltip1") {
//                    GlassContainerView(
//                        colorOpacity: 0.0,
//                        materialOpacity: 0.0,
//                        textContent: "XXXXXXXXXXXX",
//                        colorText: .red,
//                        colorBackground: .white
//                    )
//                }
                
               
                
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
