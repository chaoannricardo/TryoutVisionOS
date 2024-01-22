import Foundation
import RealityKit
import RealityKitContent


class PhysicsInteractionModel {
    
    var modelEntity = ModelEntity()
    var entityLoaded = Entity()
    
    
    @MainActor func load3DModels() async {
        
        if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
            
            modelEntity = scene.findEntity(named: "Sphere") as! ModelEntity
            entityLoaded = scene.findEntity(named: "Fan") ?? Entity()
        
        }
        
    }
    
    
    func createPhysics(){
        
        
        
        
    }

    
}
