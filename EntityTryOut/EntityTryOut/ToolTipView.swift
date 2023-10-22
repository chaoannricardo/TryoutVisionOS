//
//  ToolTipView.swift
//  EntityTryOut
//
//  Created by Ricardo on 2023/10/22.
//

import SwiftUI

struct ToolTipView: View {
    
    var textContent: String = "HelloWorld"
    
    private var titleFont: Font {
        .system(size: 48, weight: .semibold)
    }

    
    var body: some View {
    
        Text(textContent)
            .background(.red)
            .font(titleFont)

    }
    
}



#Preview {
    ToolTipView()
}

