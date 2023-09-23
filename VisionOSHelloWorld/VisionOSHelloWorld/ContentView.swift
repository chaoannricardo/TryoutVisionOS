//
//  ContentView.swift
//  VisionOSHelloWorld
//
//  Created by Ricardo on 2023/7/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var showImmersiveSpace = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        NavigationSplitView {
            List {
                Text("Ricardo's First VisionOS App")
                Text("VisionOS Hello World")
            }
            .navigationTitle("Sidebar")
        } detail: {
            VStack {
//                Model3D(named: "Scene", bundle: realityKitContentBundle)
//                    .padding(.bottom, 50)

                
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 5)

                Text("Hello, Ricardo, this is your first VisionOS App!")

                Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                    .padding(.top, 50)
            }
            .navigationTitle("Content")
            .padding()
        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    await openImmersiveSpace(id: "ImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }
    
    
    
    
    
    
}

#Preview {
    ContentView()
}
