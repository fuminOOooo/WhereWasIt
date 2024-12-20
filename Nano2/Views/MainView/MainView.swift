//
//  MainView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/19/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        ZStack {
            
            MainMapView()
            
            FirstTimeOpenView()
            
        }
        
    }
    
}

#Preview {
    
    MainView()
    
}
