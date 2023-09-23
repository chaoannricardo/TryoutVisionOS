//
//  WorkListView.swift
//  VisionCourse
//
//  Created by Ricardo on 2023/8/6.
//

import SwiftUI

struct WorkListView: View {
    @State var workList: WorkList
    @State private var showAddItemAlert: Bool = false
    @State private var newWorkItemContent: String = ""
    
    var body: some View {
        List(workList.workitems){item in
            Text(item.title)
            
        }
        .navigationTitle("Detail for \(workList.title)")
        .toolbar{
            Button("Add work item")
            {
                showAddItemAlert.toggle()
            }
        }
        .id(workList.id)
        .alert("Add New Work Item", isPresented: $showAddItemAlert){
            TextField("New Work Item", text: $newWorkItemContent)
            Button("Submit"){
                let workitem = WorkItem(title: newWorkItemContent, isDone: false)
                workList.workitems.append(workitem)
                
                
            }
            Button("Cancel", role: .cancel, action: {})
            
        }
    }
}

//#Preview {
//    WorkListView()
//}
