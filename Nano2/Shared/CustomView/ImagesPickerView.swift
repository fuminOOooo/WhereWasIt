//
//  ImagesPickerView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI
import PhotosUI
struct ImagesPickerView: View {
    
    public init(vm: PicturesViewModel) {
        self.vm = vm
    }
    
    @ObservedObject private var vm : PicturesViewModel
    
    @ViewBuilder
    private var allImages: some View {
        
        ForEach(vm.attachments) { attachment in
            
            HStack {
                
                switch attachment.imageStatus {
                    
                case .finished(let image):
                    
                    NavigationLink(
                        destination: ImageDetailView(imageShown: image)
                    ) {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: UIScreen.main.bounds.width * NumberConstant.smallerImageHeightMultiplier)
                    }
                    
                case .failed:
                    Image(systemName: ImageNameConstant.exclamationTriangleImage)
                    
                default:
                    
                    ZStack {
                        
                        Image(systemName: ImageNameConstant.squareFillImage)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.primary)
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: NumberConstant.tighterCornerRadiusSize
                                )
                            )
                        
                        ProgressView()
                        
                    }
                    
                }
                
            }
            .padding()
            .task {
                await attachment.loadImage()
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: NumberConstant.tighterCornerRadiusSize
                )
            )
            
        }
        
    }
    
    @ViewBuilder
    private var newImage: some View {
        
        PhotosPicker(
            selection: $vm.selection,
            selectionBehavior: .continuousAndOrdered,
            matching: .images,
            preferredItemEncoding: .current,
            photoLibrary: .shared()
        ) {
            HStack {
                Image(systemName: ImageNameConstant.photoBadgePlusImage)
                Text(StringConstant.pickImage)
            }
        }
        .photosPickerAccessoryVisibility(.visible, edges: .all)
        .frame(maxWidth: .infinity)
        .padding(.top)
        .withFillButtonStyle()
        
    }
    
    
    var body: some View {
        
        VStack {
            
            if (!vm.attachments.isEmpty) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(alignment: .center) {
                        
                        allImages
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .scrollDisabled($vm.attachments.isEmpty)
                
            }
            
            newImage
            
        }
        
    }
    
}
