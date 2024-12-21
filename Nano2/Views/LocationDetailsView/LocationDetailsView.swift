//
//  LocationDetailsView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI

struct LocationDetailsView: View {
    
    public init(locationItem: LocationItem) {
        self.locationItem = locationItem
    }
    
    private var locationItem : LocationItem
    @StateObject private var vm : LocationDetailsViewModel = .init()
    
    var body: some View {
        
        ScrollView {
            
            Text(vm.getItemName(locationItem))
                .font(.largeTitle)
                .bold()
            
            Text(vm.getItemTimestamp(locationItem))
                .padding(.bottom)
            
            ZStack {
                
                Image(systemName: ImageNameConstant.squareFillImage)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.black)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: NumberConstant.tighterCornerRadiusSize
                        )
                    )
                
                if vm.checkForItemMedia(locationItem) {
                    
                    
                    
                } else {
                    
                    VStack {
                        
                        Text(StringConstant.noPicturesTaken)
                            .foregroundStyle(Color.primary)
                            .padding()
                        
                        Button {
                            
                        } label: {
                            
                            HStack {
                                
                                Image(systemName: ImageNameConstant.cameraImage)
                                
                                Text(StringConstant.takePictures)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        .padding(.horizontal)
        
    }
    
}
