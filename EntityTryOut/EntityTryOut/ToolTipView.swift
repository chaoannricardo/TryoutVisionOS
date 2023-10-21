//
//  ToolTipView.swift
//  EntityTryOut
//
//  Created by Ricardo on 2023/10/22.
//

import SwiftUI

struct ToolTipView: View {
    
    private var titleFont: Font {
        .system(size: 48, weight: .semibold)
    }

    
    var body: some View {
    
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(.red)
            .font(titleFont)

    }
    
}



#Preview {
    ToolTipView()
}

