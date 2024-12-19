//
//  FirstTimeModal.swift
//  TesMapKit
//
//  Created by Elvis Susanto on 25/05/23.

import SwiftUI

struct FirstTimeModal: View {
    
    @Binding var firstTime: Bool
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading) {
                
                Text("Welcome to")
                    .font(CustomFont.lightText14)
                
                Text("Where Was It?")
                    .font(CustomFont.expandedBold)
                
                Divider()
                    .overlay(Color.white)
                    .padding(.bottom)
                
                Text(
                    "An app created for your sudden \"I'll visit this place again later, gotta note it just in case..\" type of situations."
                )
                .font(CustomFont.lightText17)
                
            }
            .foregroundColor(Color.white)
            .padding(.bottom)
            
            Button {
                
                withAnimation {
                    firstTime.toggle()
                }
                
            } label: {
                
                Text("Get started")
                
            }
            .buttonStyle(FillButton())
            
        }
        .padding()
        .background(CustomColor.darkGray)
        .cornerRadius(8)
        .padding()
        
    }
    
}
