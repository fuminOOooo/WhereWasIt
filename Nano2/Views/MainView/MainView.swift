//
//  MainView.swift
//  Nano2
//
//  Created by Elvis Susanto on 12/19/24.
//

import SwiftUI

struct MainView: View {
    
    public init (
        vm: MainViewModel = MainViewModel()
    ) {
        self.vm = vm
    }
    
    @ObservedObject var vm : MainViewModel
    
    var body: some View {
        
        ZStack {
            
            MainMapView()
            
            FirstTimeOpenView(sheetVisibility: $vm.sheetVisibility)
            
        }
        .sheet(isPresented: $vm.sheetVisibility) {
            
            MainSheetView()
                        
        }
        
    }
    
}

#Preview {
    
    MainView()
    
}
