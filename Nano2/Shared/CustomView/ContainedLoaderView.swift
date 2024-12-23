//
//  ContainedLoaderView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/23/24.
//

import SwiftUI

struct ContainedLoaderView: View {
    
    var body: some View {
        
        ProgressView(StringConstant.loading)
            .progressViewStyle(.circular)
            .padding()
            .background(
                RoundedRectangle
                    .init(
                        cornerRadius: NumberConstant.defaultCornerRadiusSize
                    )
                    .foregroundStyle(.primary)
                    .opacity(
                        CGFloat(NumberConstant.defaultPeekDetentFractionValue).halved()
                    )
            )
            .aspectRatio(
                contentMode: .fit
            )
            
    }
    
}

#Preview {
    ContainedLoaderView()
}
