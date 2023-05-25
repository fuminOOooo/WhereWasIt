//
//  FirstTimeModal.swift
//  TesMapKit
//
//  Created by Elvis Susanto on 25/05/23.

import SwiftUI

struct ConfirmationModal: View {
    
    @Binding var deleting: Bool
    
    @Binding var acceptance: Bool
    
    var body: some View {
        
        VStack () {
            
            VStack (alignment: .leading) {
                
                Text("Delete the point you previously created?")
                    .font(Font.custom("SF-Pro-Text-Light", size: 14))
                    .foregroundColor(Color.white)
                
            }
            .frame(minWidth: 350)
            .padding()
            
            HStack {
                
                Button {
                    self.deleting = false
                    self.acceptance = true
                } label: {
                    Text("Delete")
                        .frame(maxWidth: 120)
                }
                .buttonStyle(FillButton())
                
                Button {
                    self.deleting = false
                    self.acceptance = false
                } label: {
                    Text("Cancel")
                        .frame(maxWidth: 120)
                }
                .buttonStyle(BorderButton())
                
            }
            
        }
        .padding(.init(top: 24, leading: 20, bottom: 24, trailing: 20))
        .frame(maxWidth: 306)
        .background(Color(#colorLiteral(red: 0.122528699, green: 0.1234056122, blue: 0.1218643707, alpha: 1)))
        .cornerRadius(15)
        .opacity(deleting ? 1 : 0)
        .scaleEffect(deleting ? 1 : 0)
        .animation(.spring(response: 0.4, dampingFraction: 0.8))
        .transition(.move(edge: .bottom))
    }
    
}
