//
//  ContentView.swift
//  RealWorldAnchor
//
//  Created by Ricardo Chao on 2024/1/14.
//

import SwiftUI
import RealityKit
import RealityKitContent

import ARKit


struct ContentView: View {

    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    let session = ARKitSession()
    let imageInfo = ImageTrackingProvider(
        referenceImages: ReferenceImage.loadReferenceImages(
            inGroupNamed: "AR Resources",
            bundle: nil
        )
    )
    @State var modelTarget = Entity()
    @State var funcPancel = Entity()
    @State var meshAnchor = Entity()
    
    let modelWorldTracking = WorldTrackingModel()
    let modelPlaneTracking = PlaneTrackingModel()
    
    
//    func updateImage(_ anchor: ImageAnchor) {
//        if imageAnchors[anchor.id] == nil {
//            // Add a new entity to represent this image.
//            let entity = ModelEntity(mesh: .generateSphere(radius: 0.05))
//            entityMap[anchor.id] = entity
//            rootEntity.addChild(entity)
//        }
//        
//        if anchor.isTracked {
//            entityMap[anchor.id]?.transform = Transform(matrix: anchor.originFromAnchorTransform)
//        }
//    }
    

    func imageSensing(){
        
        // tracking image with ARKit
        print(ImageTrackingProvider.isSupported)
        if ImageTrackingProvider.isSupported {
            Task {
                try await session.run([imageInfo])
                
                for await update in imageInfo.anchorUpdates {
                    print("Picture Detected")
                    print(update.anchor)
//                            updateImage(update.anchor)
                    
                    // placing model to the ARKit location
                    await modelTarget.setPosition(
                        SIMD3<Float>(x: -0.2, y: -0, z: 0.2), relativeTo: nil)
                    
                }
            }
        } else {
            
            // could not activate this feature when in a simulator
            print("ImageTrackingProvide is not supported (in simulator)")
        }
        
    }
    
    var body: some View {
        VStack {
            
            RealityView { content, attachments in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    
                    funcPancel = attachments.entity(for: "FuncPanel") ?? Entity()
                    
                    // read in model target
                    modelTarget = scene.findEntity(named: "Fan") ?? Entity()
                    funcPancel.setPosition(SIMD3<Float>(x: 0, y: -0.1, z: 0), relativeTo: modelTarget)
                    
                    
                    scene.addChild(funcPancel)
                    scene.addChild(modelTarget)
                    
                    
                    content.add(modelWorldTracking.rootEntity)
                    
                    content.add(scene)
                    
                }
            
            } update: { content, attachments in
                
                imageSensing()
                
            } attachments: {
                Attachment(id: "FuncPanel"){
                    HStack {
                        Button("World Sensing"){}
                        Button("Image Sensing"){imageSensing()}.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }
            
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })
            .task {
                // world tracking
//                await modelWorldTracking.run(
//                    enableGeoMesh: true,
//                    enableMeshClassfication: true)
                
                // plane tracking
//                await modelPlaneTracking.run(
//                    enablePlaneClassification: true
//                )
                
                // image tracking

                
            }
            .onDisappear{
                modelWorldTracking.stop()
            }
            
        
        }

    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
