//
//  StepInfoView.swift
//  PhysicsInteraction
//
//  Created by Ricardo Chao on 2024/1/22.
//

import Foundation
import SwiftUI


struct StepInfoView: View {
    
    var titleText: String
    var infoText: String
    var colorText: UIColor
    
    var body: some View {
        
        VStack{
            Text(titleText).font(.title)
            Text(infoText).font(.body)
            
        }
        
    }
    
}
