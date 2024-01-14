//
//  Models.swift
//  VisionCourse
//
//  Created by Ricardo on 2023/8/6.
//

import Foundation


struct WorkList: Identifiable {
    let id = UUID()
    let title: String
    
    var workitems: [WorkItem]
    
}


struct WorkItem: Identifiable{
    let id = UUID()
    let title: String
    var isDone: Bool
    
    
}
