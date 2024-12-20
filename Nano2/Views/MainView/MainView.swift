//
//  MainView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/19/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var showingSheet : Bool = true
    
    var body: some View {
        
        ZStack {
            
            MainMapView()
            
            FirstTimeOpenView()
            
        }
        .sheet(isPresented: $showingSheet) {
            
            MainSheetView()
            
        }
        
    }
    
}

#Preview {
    
    MainView()
    
}
