//
//  PicturesView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI
import PhotosUI

struct PicturesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    public init(_ availability: Bool, item: LocationItem) {
        self.mediaAvailability = availability
        self.item = item
    }
    
    private let mediaAvailability : Bool
    
    @State private var item: LocationItem
    
    @State private var vm: PicturesViewModel = .init()
    
    @State private var imagePicked : PhotosPickerItem? = nil
    
    @State private var showImagePicker : Bool = false
    
    @State private var selectedPictureOption : PicturesOption = .none
    
    var body: some View {
        
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
            
            if mediaAvailability {
                
                ScrollView(.horizontal) {
                    
                    ForEach(vm.imagesDatas, id: \.self) { data in
                        
                        Image(
                            uiImage: UIImage(
                                data: data
                            ) ?? UIImage()
                        )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                    }
                    
                }
                .padding()
                
            } else {
                
                VStack {
                    
                    Button {
                        // TODO: Navigate to a picture taking view
                    } label: {
                        HStack {
                            Image(systemName: ImageNameConstant.cameraImage)
                            Text(StringConstant.takePictures)
                        }
                    }
                    .padding()

                    PhotosPicker(
                        selection: $imagePicked,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        HStack {
                            Image(systemName: ImageNameConstant.photoBadgePlusImage)
                            Text(StringConstant.pickImage)
                        }
                    }
                    .photosPickerAccessoryVisibility(.visible, edges: .all)
                    .onChange(of: imagePicked, {
                        if let imagePicked {
                            vm.loadTransferable(
                                from: imagePicked,
                                item: item,
                                context: viewContext
                            )
                        }
                    })

                }
                
            }
            
        }
        
    }
}

extension PicturesView {
    
    enum PicturesOption: String, CaseIterable, Identifiable {
        var id: Self { self }
        case camera
        case gallery
        case none
    }
    
}
