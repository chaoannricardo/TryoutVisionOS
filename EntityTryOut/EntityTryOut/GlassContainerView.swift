// https://stackoverflow.com/questions/76017597/how-do-i-create-glass-panels-in-swiftui-without-using-the-material-structure

import SwiftUI


public struct GlassContainerView: View {
    
//    @State var colorOpacity: Double = 0.0
//    @State var materialOpacity: Double = 0.0
//    @State var textContent: String = "XXXXXXXXXXXXXXXXX"
//    @State var colorText: Color = .red
//    @State var colorBackground: Color = .white
    
    let colorOpacity: Double
    let materialOpacity: Double
    let textContent: String
    let colorText: Color
    let colorBackground: Color
    
    
    public var body: some View {
        ZStack {
            colorBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Text(textContent)
                        .foregroundColor(colorText)
                        .font(.title3)
                    Rectangle()
                        .fill(
                            Material.thin
                        )
                        .opacity(materialOpacity)
                    
                    Color(
                        red: 255/255,
                        green: 255/255,
                        blue: 255/255,
                        opacity: colorOpacity)
                }
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .border(
                    Color(
                        red: 255/255,
                        green: 255/255,
                        blue: 255/255,
                        opacity: 0.1
                    )
                )
                .cornerRadius(15)
//                    .frame(width: 500, height: 100)
                
                
//                Spacer()
//                VStack(spacing: 0) {
//                    Text("Material Opacity:")
//                    Slider(value: $materialOpacity)
//                }
//                .padding()
//
//                VStack(spacing: 0) {
//                    Text("Color Opacity:")
//                    Slider(value: $colorOpacity)
//                }
//                .padding()
//                Spacer()
            }
        }
    }
}




#Preview {
    GlassContainerView(
        colorOpacity: 0.0,
        materialOpacity: 0.0,
        textContent: "XXXXXXXXXXXX",
        colorText: .red,
        colorBackground: .white
    )
}
