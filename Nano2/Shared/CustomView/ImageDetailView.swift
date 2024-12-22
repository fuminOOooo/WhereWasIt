//
//  ImageDetailView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI

struct ImageDetailView: View {
    
    public init(imageShown: Image) {
        self.imageShown = imageShown
    }
    
    private var imageShown : Image
    
    var body: some View {
        
        VStack {
            
            imageShown
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
        .padding()
        
    }
    
}
