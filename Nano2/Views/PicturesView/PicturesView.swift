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
    
    public init(
        item: LocationItem
    ) {
        self.item = item
        self.vm = .init()
    }
    
    private var item: LocationItem
    
    @ObservedObject private var vm: PicturesViewModel
    
    var body: some View {
        
        VStack {
                
            Text(String(vm.attachments.count) + StringConstant.space + StringConstant.imagesGiven)
                .bold()
            
            ImagesPickerView(vm: vm)
            
        }
        
    }
}
