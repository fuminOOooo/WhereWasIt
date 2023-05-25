//
//  FirstTimeModal.swift
//  TesMapKit
//
//  Created by Elvis Susanto on 25/05/23.

import SwiftUI

struct InfoModal: View {
    
    @Binding var infoClicked: Bool
    
    var body: some View {
        
        VStack () {
            
            VStack (alignment: .leading) {
                
                Text("What do i do on")
                    .font(Font.custom("SF-Pro-Text-Light", size: 14))
                    .foregroundColor(Color.white)
                
                Text("Where Was It?")
                    .font(Font.custom("SFPro-ExpandedBold", size: 28))
                    .foregroundColor(Color.white)
                
                Divider()
                    .overlay(Color.white)
                    .frame(width: 260)
                    .padding(.bottom)
                
                Text("When you find yourself a place")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                    .lineLimit(nil)
                
                Text("you would like to re-visit,")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                    .lineLimit(nil)
                
                Text("")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
            }
            .frame(minWidth: 250)
            
            VStack (alignment: .leading) {
                
                Text("click on the button : ")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("Set whereabouts")
                    .underline()
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("The app will then create a clickable and customizable annotation,")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
                Text("on the app's main view.")
                    .font(Font.custom("SF-Pro-Text-Light", size: 17))
                    .foregroundColor(Color.white)
                
            }
            .frame(minWidth: 250)
            
            Button {
                infoClicked.toggle()
            } label: {
                Text("Got it")
                    .frame(maxWidth: 270)
            }
            .buttonStyle(FillButton())
            
            
        }
        .padding(.init(top: 24, leading: 20, bottom: 24, trailing: 20))
        .frame(maxWidth: 306)
        .background(Color(#colorLiteral(red: 0.122528699, green: 0.1234056122, blue: 0.1218643707, alpha: 1)))
        .cornerRadius(15)
        .opacity(infoClicked ? 1 : 0)
        .scaleEffect(infoClicked ? 1 : 0)
        .animation(.spring(response: 0.4, dampingFraction: 0.8))
        .transition(.move(edge: .bottom))
    }
    
}
