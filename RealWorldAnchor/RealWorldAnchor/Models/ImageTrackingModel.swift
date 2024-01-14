

import ARKit
import Foundation
import RealityKit
import RealityKitContent
import ARKit

class ImageTrackingModel: TrackingModel {
    
    // https://developer.apple.com/documentation/visionos/tracking-images-in-3d-space
    
    let imageInfo = ImageTrackingProvider(
        referenceImages: ReferenceImage.loadReferenceImages(inGroupNamed: "playingcard-photos")
    )
    
    @MainActor func run(enableGeoMesh: Bool, enableMeshClassfication: Bool) async {
        var providers: [DataProvider] = []
        if ImageTrackingProvider.isSupported {
            Task {
                   try await session.run([imageInfo])
                   for await update in imageInfo.anchorUpdates {
                       updateImage(update.anchor)
                   }
               }
        }
        
//        do {
//            try await session.run(providers)
//            for await sceneUpdate in sceneDataProvider.anchorUpdates {
//                let anchor = sceneUpdate.anchor
//                let geometry = anchor.geometry
//                switch sceneUpdate.event {
//                    case .added:
//                        // print classifications
//                        print("add anchor classification is \(String(describing: geometry.classifications))")
//                        try await createMeshEntity(geometry, anchor)
//                    case .updated:
//                        print("update")
//                        try await updateMeshEntity(geometry, anchor)
//                    case .removed:
//                        print("removed anchor classification is \(String(describing: geometry.classifications))")
//                        try removeMeshEntity(geometry, anchor)
//                }
//            }
//        } catch {
//            print("error is \(error)")
//        }
    }
    
    func updateImage(_ anchor: ImageAnchor) {
        if imageAnchors[anchor.id] == nil {
            // Add a new entity to represent this image.
            let entity = ModelEntity(mesh: .generateSphere(radius: 0.05))
            entityMap[anchor.id] = entity
            rootEntity.addChild(entity)
        }
        
        if anchor.isTracked {
            entityMap[anchor.id]?.transform = Transform(matrix: anchor.originFromAnchorTransform)
        }
    }
    
    // MARK: Geometry Mesh
    
    @MainActor fileprivate  func createMeshEntity(_ geometry: MeshAnchor.Geometry, _ anchor: MeshAnchor) async throws  {
        let modelEntity = try await generateModelEntity(geometry: geometry)
        let anchorEntity = AnchorEntity(world: anchor.originFromAnchorTransform)
        anchorEntity.addChild(modelEntity)
        anchorEntity.name = "MeshAnchor-\(anchor.id)"
        rootEntity.addChild(anchorEntity)
    }
    
    @MainActor fileprivate func updateMeshEntity(_ geometry: MeshAnchor.Geometry, _ anchor: MeshAnchor) async throws {
        let modelEntity = try await generateModelEntity(geometry: geometry)
        if let anchorEntity = rootEntity.findEntity(named: "MeshAnchor-\(anchor.id)") {
            anchorEntity.children.removeAll()
            anchorEntity.addChild(modelEntity)
        }
    }
    
    fileprivate func removeMeshEntity(_ geometry: MeshAnchor.Geometry, _ anchor: MeshAnchor) throws {
        if let anchorEntity = rootEntity.findEntity(named: "MeshAnchor-\(anchor.id)") {
            anchorEntity.removeFromParent()
        }
    }
    
    
    @MainActor fileprivate func generateModelEntity(geometry: MeshAnchor.Geometry) async throws -> Entity {
        // load entity from realityKitContent
        
        var modelEntity = Entity()
        
        if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
        
            // read in model target
            modelEntity = scene.findEntity(named: "Fan") ?? Entity()
            
        }
        return modelEntity
        
    }
}
