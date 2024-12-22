//
//  LocationDetailsView.swift
//  Nano2
//
//  Created by Elvis Susanto on 22/12/24.
//

import SwiftUI
import CoreLocation

struct LocationDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var vm : LocationDetailsViewModel = .init()
    
    @State private var locationDescription : String
    @State private var deleting : Bool = false
    
    private var locationItem : LocationItem
    
    public init(
        locationItem: LocationItem
    ) {
        self.locationItem = locationItem
        if let description = locationItem.textDescription {
            locationDescription = description
        } else {
            locationDescription = String()
        }
    }
    
    var body: some View {
        
        
        VStack {
            
            Text(vm.getItemName(locationItem))
                .font(.largeTitle)
                .bold()
            
            Text(StringConstant.savedOn + StringConstant.space + vm.getItemTimestamp(locationItem))
                .padding(.bottom)
            
            List {
                
                Section(StringConstant.media, content: pictures)
                
                Section(StringConstant.description, content: description)
                
                Section(StringConstant.details, content: details)
                
                Button (
                    StringConstant.delete + StringConstant.space + (locationItem.name ?? String()),
                    role: .destructive
                ) {
                    deleting = true
                }
                
            }
            .alert(
                StringConstant.delete +
                StringConstant.space +
                (locationItem.name ?? String()) +
                StringConstant.questionMark,
                isPresented: $deleting
            ) {
                alert()
            }
            
        }
        
    }
    
}

private extension LocationDetailsView {
    
    private func saveChanges() {
        
        do {
            try viewContext.save()
        } catch {
            print(StringConstant.failedSave)
        }
        
    }
    
    private func saveCurrentLocationDescription() {
        
        locationItem.textDescription = locationDescription
        
        saveChanges()
        
    }
    
    private func deleteItem() {
        
        viewContext.delete(locationItem)
        
        saveChanges()
        
    }
    
    @ViewBuilder private func pictures() -> some View {
        
        PicturesView(
            item: locationItem
        )
        .padding(.vertical)
        
    }
    
    @ViewBuilder private func description() -> some View {
        
        TextField(
            StringConstant.enterLocationDescription,
            text: $locationDescription
        )
        .padding(.top)
        
        Button {
            saveCurrentLocationDescription()
        } label: {
            HStack {
                Spacer()
                Image(systemName: ImageNameConstant.noteImage)
                Text(StringConstant.saveDescription)
            }
            .bold(locationDescription != locationItem.textDescription)
        }
        .padding(.vertical)
        .disabled(locationDescription == locationItem.textDescription)
        
    }
    
    @ViewBuilder private func details() -> some View {
        
        Text(StringConstant.latitudeDescription + StringConstant.space + String(locationItem.latitude))
        
        Text(StringConstant.longitudeDescription + StringConstant.space + String(locationItem.longitude))
        
    }
    
    @ViewBuilder private func alert() -> some View {
        
        InputAlertView(
            cancelAction: {
                deleting = false
            },
            buttonText: StringConstant.delete,
            buttonRole: .destructive,
            buttonAction: {
                deleteItem()
                dismiss()
            }
        )
        
    }
    
}
