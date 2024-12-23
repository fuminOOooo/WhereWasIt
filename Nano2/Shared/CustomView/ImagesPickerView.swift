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
    
    var body: some View {
        
        VStack {
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center) {
                    allImages()
                }
            }
            .scrollDisabled($vm.attachments.isEmpty)
            
            imagePicker()
            
        }
        
    }
    
}

private extension ImagesPickerView {
    
    @ViewBuilder private func allImages() -> some View {
        
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
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: NumberConstant.tighterCornerRadiusSize
                                )
                            )
                    }
                    
                case .failed:
                    Image(systemName: ImageNameConstant.exclamationTriangleImage)
                    
                default:
                    ContainedLoaderView()
                    
                }

            }
            .padding()
            .task {
                await attachment.loadImage()
            }
            
        }
        
    }
    
    @ViewBuilder private func imagePicker() -> some View {
        
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
        .withFillButtonStyle()
        .photosPickerAccessoryVisibility(.visible, edges: .all)
        .padding(.top)
        
    }
    
}
