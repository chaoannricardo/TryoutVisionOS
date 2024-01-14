//
//  ContentView.swift
//  VisionCourse
//
//  Created by Ricardo on 2023/8/6.
//

import SwiftUI
//import RealityKit
//import RealityKitContent

struct ContentView: View {
    @State private var worklists: [WorkList] = []
    @State private var selectedWorklist: WorkList? = nil
    
    @State private var showAddListAlert: Bool = false
    @State private var newWorkListTitle: String = ""
    
    
    var body: some View {
        
        
        
        NavigationSplitView {
            List(worklists){ worklist in
                Button(worklist.title){
                    selectedWorklist = worklist
                    
                    
                }
            }
            .navigationTitle("Work Lists")
            .toolbar{
                Button("Add"){
                    showAddListAlert.toggle()

                }
                Button("Delete"){
                    
                }
                
            }
            .alert("Add Work List", isPresented: $showAddListAlert){
                TextField("New Work List Title", text: $newWorkListTitle)
                Button("Cancel", role: .cancel, action: {})
                Button("Create"){
//                    let workList = WorkList(title: "List \(worklists.count + 1)", workitems: [])
                    let workList = WorkList(title: newWorkListTitle, workitems: [])
                    worklists.append(workList)
                }
            }
            
        } detail: {
            
            if let selectedWorklist
            {
                
                WorkListView(workList: selectedWorklist)
                
            }
            
            
            
            
            
        }
        
        
        
        
        
        //        
        //        NavigationSplitView {
        //            List {
        //                Text("Item")
        //            }
        //            .navigationTitle("Sidebar")
        //        } detail: {
        //            VStack {
        //                Model3D(named: "Scene", bundle: realityKitContentBundle)
        //                    .padding(.bottom, 50)
        //
        //                Text("Hello, world!")
        //            }
        //            .navigationTitle("Content")
        //            .padding()
        //        }
        //
        
        
           
    }
}

#Preview {
    ContentView()
}
