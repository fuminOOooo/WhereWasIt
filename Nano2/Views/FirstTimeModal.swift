//
//  FirstTimeModal.swift
//  TesMapKit
//
//  Created by Elvis Susanto on 25/05/23.

import SwiftUI

struct FirstTimeModal: View {
    
    @Binding var firstTime: Bool
    
    var body: some View {
        
        VStack () {
            
            VStack (alignment: .leading) {
                
                Text("Welcome to")
                    .font(Font.custom("SF-Pro-Text-Light", size: 14))
                    .foregroundColor(Color.white)
                
                Text("Where Was It?")
                    .font(Font.custom("SFPro-ExpandedBold", size: 28))
                    .foregroundColor(Color.white)
                
                Divider()
                    .overlay(Color.white)
                    .frame(width: 260)
                    .padding(.bottom)
                
                Text("An app created for your sudden")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("\"I'll visit this place again later,")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("gotta note it just in case..\"")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("type of situations.")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
            }
            .frame(minWidth: 250)
            .padding()
            
            Button {
                firstTime.toggle()
            } label: {
                Text("Get started")
                    .frame(maxWidth: 270)
            }
            .buttonStyle(FillButton())
            
            
        }
        .padding(.init(top: 24, leading: 20, bottom: 24, trailing: 20))
        .frame(maxWidth: 306)
        .background(Color(#colorLiteral(red: 0.122528699, green: 0.1234056122, blue: 0.1218643707, alpha: 1)))
        .cornerRadius(15)
        .opacity(firstTime ? 1 : 0)
        .scaleEffect(firstTime ? 1 : 0)
        .animation(.spring(response: 0.4, dampingFraction: 0.8))
        .transition(.move(edge: .bottom))
    }
    
}
